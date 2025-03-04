-- lsp.lua
-- Andrew Barlow
--
-- Language Server Protocol plugin configs

-- commenting out options that are probably not needed/wanted for all installs
local language_servers = require('plugins.config.lsp').lsp_list

-- formatters
-- TODO: automatically install formatters as well as LSPs
local formatters = require('plugins.config.lsp').formatter_list

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
    config = function()
      require('lazydev').setup({
        library = {
          'nvim-dap-ui',
        },
      })
    end
  },

  { -- Mason: LSP manager
    'williamboman/mason.nvim',
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require('mason').setup()

      -- TODO: automatic DAP/LSP/Formatter installation
      local dap_list = require('plugins.config.dap').dap_list

      -- BUG: no automatic DAP installation
      require('mason-nvim-dap').setup({
        ensure_installed = dap_list,
        -- TODO: inspect if further config neccessary
        handlers = {
          function (config)
            require('mason-nvim-dap').default_setup(config)
          end
        },
        automatic_installation = false
      })

    end
  },

  {
      "williamboman/mason-lspconfig.nvim",
      config = require('plugins.config.mason_lspconfig').config,
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
