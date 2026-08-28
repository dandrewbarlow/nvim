-- lsp.lua
-- Andrew Barlow
--
-- Language Server Protocol plugin configs


return {
  { -- formatter: install and use formatters to make files neater
    'stevearc/conform.nvim',
    opts = {},
    keys = require('plugins.config.conform').keys,
    config = require('plugins.config.conform').config,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
          "folke/lazydev.nvim",
          opts = {},
          ft = "lua", -- only load on lua files
        },
    },
  },

  {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
  },

  {
    'kosayoda/nvim-lightbulb',
    config = function ()
      require('nvim-lightbulb').setup({
        autocmd = {enabled = true},
      })
    end
  },
}
