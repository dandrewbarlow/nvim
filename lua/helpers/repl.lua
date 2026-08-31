-- repl.lua
-- Andrew Barlow
--
-- On-demand REPL servers for conjure.
--
-- Conjure's common lisp and guile clients both only know how to *connect* to a
-- server that's already running, so starting one has to happen here. Each is
-- spawned as a plain (non-detached) job, which means opening a file is enough
-- to get a REPL and nothing is left running once nvim exits.
--
-- Anything already listening is reused rather than duplicated, so starting a
-- server by hand still works exactly as it did before.

local M = {}

local defaults = {
  -- how long a single "is anything listening?" check may take
  probe_timeout = 250,

  -- sbcl + quicklisp + swank is ~325ms, guile is quicker, so this normally
  -- lands on the first or second poll
  poll_interval = 400,
  poll_attempts = 30,
}

-- shared connect-or-give-up dance for a libuv handle
local function probe_handle(handle, timeout, connect, cb)
  if not handle then
    return cb(false)
  end

  local settled = false
  local function settle(open)
    if settled then
      return
    end
    settled = true
    pcall(function() handle:close() end)
    vim.schedule(function() cb(open) end)
  end

  connect(handle, function(err) settle(err == nil) end)
  vim.defer_fn(function() settle(false) end, timeout)
end

local probes = {}

function probes.tcp(cfg, cb)
  probe_handle(vim.uv.new_tcp(), cfg.probe_timeout, function(h, done)
    h:connect(cfg.host, cfg.port, done)
  end, cb)
end

function probes.pipe(cfg, cb)
  -- no socket file at all means nothing to connect to
  if not vim.uv.fs_stat(cfg.pipename) then
    return cb(false)
  end

  probe_handle(vim.uv.new_pipe(false), cfg.probe_timeout, function(h, done)
    h:connect(cfg.pipename, done)
  end, cb)
end

local function new(spec)
  local cfg = vim.tbl_extend("force", vim.deepcopy(defaults), spec.config)
  local state = { job = nil, pending = false, warned = false, attached = false }
  local server = { config = cfg }

  local function connect()
    local ok, client = pcall(require, spec.client)
    if ok and client and client.connect then
      pcall(client.connect, {})
    end
  end

  local function await(attempts)
    if attempts <= 0 then
      state.pending = false
      vim.notify(
        string.format("%s: server never came up", spec.name),
        vim.log.levels.WARN
      )
      return
    end

    spec.probe(cfg, function(open)
      if open then
        state.pending = false
        state.attached = true
        connect()
      else
        vim.defer_fn(function() await(attempts - 1) end, cfg.poll_interval)
      end
    end)
  end

  local function spawn()
    if vim.fn.executable(spec.bin) == 0 then
      state.pending = false
      -- once per session, not once per buffer
      if not state.warned then
        state.warned = true
        vim.notify(
          string.format("%s: %s not found on $PATH", spec.name, spec.bin),
          vim.log.levels.WARN
        )
      end
      return
    end

    if spec.cleanup then
      spec.cleanup(cfg)
    end

    -- not detached, so nvim reaps it on exit
    local job = vim.fn.jobstart(spec.cmd(cfg), {
      on_exit = function()
        state.job = nil
        state.attached = false
      end,
    })

    if job <= 0 then
      state.pending = false
      vim.notify(string.format("%s: failed to start %s", spec.name, spec.bin), vim.log.levels.ERROR)
      return
    end

    state.job = job
    await(cfg.poll_attempts)
  end

  -- Make sure a server is reachable, then point conjure at it.
  --
  -- Only ever attaches once. Both clients' connect() start by disconnecting,
  -- so calling this again for a second buffer would tear down a working
  -- connection and redial it -- and FileType fires more than once per buffer,
  -- since lazy re-emits it after loading the plugin.
  function server.ensure()
    if state.pending or state.attached then
      return
    end
    state.pending = true

    spec.probe(cfg, function(open)
      if open then
        state.pending = false
        state.attached = true
        -- the swank client dials on load all by itself, so connecting again
        -- here would only make it drop that connection and redial. the guile
        -- client has no such hook, so it does need the nudge.
        if spec.connect_on_reuse then
          connect()
        end
      elseif state.job then
        -- already spawned, just hasn't finished booting
        await(cfg.poll_attempts)
      else
        spawn()
      end
    end)
  end

  function server.stop()
    state.attached = false
    if state.job then
      pcall(vim.fn.jobstop, state.job)
      state.job = nil
      if spec.cleanup then
        spec.cleanup(cfg)
      end
    end
  end

  return server
end

M.swank = new({
  name = "swank",
  bin = "sbcl",
  client = "conjure.client.common-lisp.swank",
  probe = probes.tcp,
  connect_on_reuse = false,
  config = {
    host = "127.0.0.1",
    port = 4005,
  },
  cmd = function(cfg)
    local cmd = { "sbcl" }

    -- there's no ~/.sbclrc here, so quicklisp has to be loaded by hand
    local setup = vim.fn.expand("~/quicklisp/setup.lisp")
    if vim.uv.fs_stat(setup) then
      vim.list_extend(cmd, { "--load", setup })
    end

    -- NOTE: deliberately no --non-interactive. swank runs in its own thread, so
    -- sbcl would exit the moment these evals finished. Without the flag sbcl
    -- sits in its REPL reading the job's stdin pipe, which never closes, and
    -- so lives exactly as long as nvim does.
    vim.list_extend(cmd, {
      "--eval", "(ql:quickload :swank)",
      "--eval", string.format("(swank:create-server :port %d :dont-close t)", cfg.port),
    })

    return cmd
  end,
})

M.guile = new({
  name = "guile",
  bin = "guile",
  client = "conjure.client.guile.socket",
  probe = probes.pipe,
  connect_on_reuse = true,
  config = {
    -- tmpfs, per-user, cleared on logout
    pipename = vim.fn.stdpath("run") .. "/guile-repl.socket",
  },
  -- guile doesn't remove its own socket file, so clear it both before starting
  -- (anything there is stale, and would stop guile binding) and after stopping
  cleanup = function(cfg)
    if vim.uv.fs_stat(cfg.pipename) then
      vim.uv.fs_unlink(cfg.pipename)
    end
  end,
  cmd = function(cfg)
    -- guile serves the socket while its own REPL sits on the job's stdin pipe,
    -- which nvim holds open for the life of the session
    return { "guile", "--no-auto-compile", "--listen=" .. cfg.pipename }
  end,
})

function M.stop_all()
  M.swank.stop()
  M.guile.stop()
end

return M
