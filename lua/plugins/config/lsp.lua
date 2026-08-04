-- language_server.lua
-- Andrew Barlow
--
-- custom list of language servers I would like auto-installed

return {
  lsp_list = {
    "bashls",
    "clangd",
    -- "clang-format",
    -- "docker_compose_language_service",
    -- "dockerls",
    -- "eslint",
    -- "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "glslls",
    -- "rust_analyzer",
    -- "sqls",
    -- "tailwindcss",
  },

  formatter_list = {
    "stylua",
    "prettier"
  },

  -- servers mason has no package for. installed by hand, so they're gated on
  -- their binary being present -- see helpers.tooling.enable_manual. `name`
  -- must match an `lsp/<name>.lua` on the runtimepath.
  manual_lsp_list = {
    -- roswell doesn't put its bin dir on $PATH for GUI-launched nvim, so
    -- accept either location -- cl_lsp.lua falls back to the same path
    { name = "cl_lsp", requires = { { "cl-lsp", "~/.roswell/bin/cl-lsp" } } },
  },

}
