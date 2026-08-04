-- tooling.lua
-- Andrew Barlow
--
-- Filter mason `ensure_installed` lists down to the tools we can actually
-- install on this machine. Many language servers / debuggers / formatters are
-- not self-contained binaries -- mason builds or fetches them with a host
-- toolchain (node, python, go, a C compiler...). On a fresh machine those
-- toolchains may be missing, and mason errors out trying to install anyway.
--
-- This gates auto-install on the required executables being present.

local M = {}

-- Map a mason package (lsp / dap / formatter name, exactly as it appears in the
-- ensure_installed lists) to the system executables required to install it.
--
-- Anything NOT listed here is assumed to ship as a self-contained prebuilt
-- binary (e.g. clangd, lua_ls, cpptools, stylua) and is always allowed.
M.requires = {
  -- node / npm based
  bashls = { "node" },
  html = { "node" },
  jsonls = { "node" },
  pyright = { "node" },
  prettier = { "node" },
  ["js-debug-adapter"] = { "node" },

  -- python based
  debugpy = { "python3" },

  -- go based
  ["go-debug-adapter"] = { "go" },

  -- built from source
  glslls = { "cmake", "cc" },
}

-- true only when every entry in `execs` resolves. An entry may be a bare name
-- (looked up on $PATH) or a path -- vim.fn.executable handles both, so a tool
-- installed outside $PATH can still be detected. A nested list means "any of
-- these will do", e.g. { { "cl-lsp", "~/.roswell/bin/cl-lsp" } }.
function M.have(execs)
  for _, entry in ipairs(execs) do
    local alternatives = type(entry) == "table" and entry or { entry }
    local found = false

    for _, exe in ipairs(alternatives) do
      if vim.fn.executable(vim.fn.expand(exe)) == 1 then
        found = true
        break
      end
    end

    if not found then
      return false
    end
  end

  return true
end

local have = M.have

-- Report the entries we passed over, once, so it's obvious why a tool didn't
-- show up (and what to install to fix it).
local function notify_skipped(reason, skipped)
  if #skipped > 0 then
    vim.notify(
      reason .. ":\n" .. table.concat(skipped, "\n"),
      vim.log.levels.WARN,
      { title = "tooling" }
    )
  end
end

-- Format one skipped entry the same way everywhere. Nested "any of" entries
-- (see M.have) are rendered as "a or b".
local function skip_entry(name, reqs)
  local parts = {}

  for _, entry in ipairs(reqs) do
    table.insert(parts, type(entry) == "table" and table.concat(entry, " or ") or entry)
  end

  return "  " .. name .. " (needs: " .. table.concat(parts, ", ") .. ")"
end

-- Return the subset of `list` whose toolchain requirements are satisfied.
-- Skipped entries are reported once via vim.notify so it's obvious why a
-- server didn't install (and what to install to fix it).
function M.installable(list)
  local ok, skipped = {}, {}

  for _, name in ipairs(list) do
    local reqs = M.requires[name]
    if not reqs or have(reqs) then
      table.insert(ok, name)
    else
      table.insert(skipped, skip_entry(name, reqs))
    end
  end

  notify_skipped("mason: skipping auto-install (missing toolchains)", skipped)

  return ok
end

-- Enable language servers that mason has no package for, so they're installed
-- by hand and may simply be absent on another machine. Same gate as
-- M.installable, but the payoff is `vim.lsp.enable` instead of an install list.
--
-- `list` entries are { name = <lsp config name>, requires = { <exec>, ... } },
-- where the name matches an `lsp/<name>.lua` on the runtimepath.
function M.enable_manual(list)
  local skipped = {}

  for _, server in ipairs(list) do
    if have(server.requires) then
      vim.lsp.enable(server.name)
    else
      table.insert(skipped, skip_entry(server.name, server.requires))
    end
  end

  notify_skipped("lsp: skipping manually-installed servers (not found)", skipped)
end

-- Install the given mason packages if they aren't already installed.
-- mason-lspconfig / mason-nvim-dap handle their own `ensure_installed`, but
-- formatters have no such bridge here, so we drive the mason registry directly.
-- Pass an already-filtered list (see M.installable) so we don't try to install
-- tools whose toolchains are missing.
function M.mason_install(list)
  if #list == 0 then
    return
  end

  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    return
  end

  local function install()
    for _, name in ipairs(list) do
      local found, pkg = pcall(registry.get_package, name)
      if found and not pkg:is_installed() then
        pkg:install()
      end
    end
  end

  -- refresh first so is_installed() reflects the current registry state
  if registry.refresh then
    registry.refresh(install)
  else
    install()
  end
end

return M
