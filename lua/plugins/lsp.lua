-- lsp.lua
-- Andrew Barlow
--
-- Language Server Protocol plugin configs

-- commenting out options that are probably not needed/wanted for all installs
local language_servers = { import = 'config.language_server_list' }

-- formatters
-- TODO: automatically install formatters as well as LSPs
-- local formatters = {
--   "stylua",
--   "prettier"
-- }

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
              -- love2d game library
              { path = os.getenv("HOME") .. ".local/share/LuaAddons/love2d/library", words = { "love" } }
            },
          },
        },
    },
  },

  { -- Mason: LSP manager
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },

  {
      "williamboman/mason-lspconfig.nvim",
      config = { import = 'config.mason_lspconfig' }
  },
}
