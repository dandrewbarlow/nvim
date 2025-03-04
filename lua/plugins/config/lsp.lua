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

}
