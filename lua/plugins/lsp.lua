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
              { path = os.getenv("HOME") .. "/.local/share/LuaAddons/love2d/library", words = { "love" } },
              "nvim-dap-ui",
            },
          },
        },
    },
    config = function()
      -- servers with no mason package are enabled here instead, gated on
      -- their binary so a machine without the toolchain just skips them
      require('helpers.tooling').enable_manual(
        require('plugins.config.lsp').manual_lsp_list
      )
    end,
  },

  { -- Mason: LSP manager
    'williamboman/mason.nvim',
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require('mason').setup()

      local tooling = require('helpers.tooling')

      -- auto-install formatters whose toolchains exist on this machine
      tooling.mason_install(
        tooling.installable(require('plugins.config.lsp').formatter_list)
      )

      local dap_list = require('plugins.config.dap').dap_list

      -- only auto-install adapters whose required toolchains exist here
      require('mason-nvim-dap').setup({
        ensure_installed = tooling.installable(dap_list),
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
