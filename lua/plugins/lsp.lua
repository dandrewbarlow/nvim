-- lsp.lua
-- Andrew Barlow
--
-- Language Server Protocol plugin configs

-- commenting out options that are probably not needed/wanted for all installs
local language_servers = {
  "bashls",
  -- "clangd",
  -- "docker_compose_language_service",
  -- "dockerls",
  -- "eslint",
  -- "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  -- "rust_analyzer",
  -- "sqls",
  -- "tailwindcss",
}

-- formatters
-- TODO: automatically install formatters as well as LSPs
--
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
            },
          },
        },
    },
    config = function()
      require('lspconfig').lua_ls.setup {}
    end
  },

  { -- Mason: LSP manager
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },

  {
      "williamboman/mason-lspconfig.nvim",
      config = function()

        local handlers = {
          function (server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('lspconfig')[server_name].setup {
              capabilities = capabilities
            }
          end
        }

        require("mason-lspconfig").setup {
          automatic_installation = false,
          ensure_installed =  language_servers,
          handlers = handlers
        }


      end
  },
}
