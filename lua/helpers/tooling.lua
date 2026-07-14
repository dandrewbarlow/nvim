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

-- true only when every executable in `execs` is on $PATH
local function have(execs)
  for _, exe in ipairs(execs) do
    if vim.fn.executable(exe) == 0 then
      return false
    end
  end
  return true
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
      table.insert(skipped, "  " .. name .. " (needs: " .. table.concat(reqs, ", ") .. ")")
    end
  end

  if #skipped > 0 then
    vim.notify(
      "mason: skipping auto-install (missing toolchains):\n" .. table.concat(skipped, "\n"),
      vim.log.levels.WARN,
      { title = "tooling" }
    )
  end

  return ok
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
