-- swank.lua
-- Andrew Barlow
--
-- On-demand swank server for conjure's common lisp client.
--
-- Conjure's CL client only knows how to *connect* to a swank server, it has no
-- notion of starting one, so the process management has to live here. Opening a
-- .lisp buffer is enough to get a working REPL, and because the server is a
-- plain (non-detached) job it dies with nvim -- no daemon left running.
--
-- Scheme needs none of this: conjure's stdio client spawns chicken itself.

local M = {}

M.config = {
  host = "127.0.0.1",
  port = 4005,

  -- how long a single "is anything listening?" check may take
  probe_timeout = 250,

  -- sbcl + quicklisp + swank is ~325ms, so this normally lands on the first
  -- or second poll
  poll_interval = 400,
  poll_attempts = 30,
}

local state = {
  job = nil,
  pending = false,
  warned = false,
  attached = false,
}

-- async check for a listener on the configured host/port
local function probe(cb)
  local tcp = vim.uv.new_tcp()
  if not tcp then
    return cb(false)
  end

  local settled = false
  local function settle(open)
    if settled then
      return
    end
    settled = true
    pcall(function() tcp:close() end)
    vim.schedule(function() cb(open) end)
  end

  tcp:connect(M.config.host, M.config.port, function(err) settle(err == nil) end)
  vim.defer_fn(function() settle(false) end, M.config.probe_timeout)
end

local function connect()
  local ok, client = pcall(require, "conjure.client.common-lisp.swank")
  if ok and client and client.connect then
    pcall(client.connect, {})
  end
end

local function build_cmd()
  local cmd = { "sbcl" }

  -- there's no ~/.sbclrc here, so quicklisp has to be loaded by hand
  local setup = vim.fn.expand("~/quicklisp/setup.lisp")
  if vim.uv.fs_stat(setup) then
    vim.list_extend(cmd, { "--load", setup })
  end

  -- NOTE: deliberately no --non-interactive. swank runs in its own thread, so
  -- sbcl would exit the moment these evals finished. Without the flag sbcl
  -- sits in its REPL reading the job's stdin pipe, which never closes, and so
  -- lives exactly as long as nvim does.
  vim.list_extend(cmd, {
    "--eval", "(ql:quickload :swank)",
    "--eval", string.format("(swank:create-server :port %d :dont-close t)", M.config.port),
  })

  return cmd
end

local function await(attempts)
  if attempts <= 0 then
    state.pending = false
    vim.notify(
      string.format("swank: nothing came up on port %d", M.config.port),
      vim.log.levels.WARN
    )
    return
  end

  probe(function(open)
    if open then
      state.pending = false
      state.attached = true
      connect()
    else
      vim.defer_fn(function() await(attempts - 1) end, M.config.poll_interval)
    end
  end)
end

local function spawn()
  if vim.fn.executable("sbcl") == 0 then
    state.pending = false
    -- once per session, not once per buffer
    if not state.warned then
      state.warned = true
      vim.notify("swank: sbcl not found on $PATH", vim.log.levels.WARN)
    end
    return
  end

  -- not detached, so nvim reaps it on exit
  local job = vim.fn.jobstart(build_cmd(), {
    on_exit = function()
      state.job = nil
      state.attached = false
    end,
  })

  if job <= 0 then
    state.pending = false
    vim.notify("swank: failed to start sbcl", vim.log.levels.ERROR)
    return
  end

  state.job = job
  await(M.config.poll_attempts)
end

-- Make sure a swank server is reachable, then point conjure at it.
--
-- Anything already listening gets reused rather than duplicated, so starting a
-- REPL by hand (ros run ... swank:create-server) still works exactly as before.
--
-- Only ever attaches once: the client's connect() starts by disconnecting, so
-- running this again for a second buffer would tear down a working connection
-- and redial it -- and FileType fires more than once per buffer, since lazy
-- re-emits it after loading the plugin.
function M.ensure()
  if state.pending or state.attached then
    return
  end
  state.pending = true

  probe(function(open)
    if open then
      -- a server was already up when the buffer opened, so the client's own
      -- on-load connect will have succeeded. dialling again here would only
      -- make it drop that connection and redial.
      state.pending = false
      state.attached = true
    elseif state.job then
      -- already spawned, just hasn't finished booting
      await(M.config.poll_attempts)
    else
      spawn()
    end
  end)
end

function M.stop()
  state.attached = false
  if state.job then
    pcall(vim.fn.jobstop, state.job)
    state.job = nil
  end
end

return M
