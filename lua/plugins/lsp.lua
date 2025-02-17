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

          -- general handler
          function (server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('lspconfig')[server_name].setup {
              capabilities = capabilities
            }
          end,

          -- custom handlers
          ['lua_ls'] = function ()
              local capabilities = require('cmp_nvim_lsp').default_capabilities()
              require('lspconfig')['lua_ls'].setup {
                capabilities = capabilities,
                -- add LuaAddons
                settings = {
                  Lua = {
                    library = {
                      {os.getenv("HOME") .. ".local/share/LuaAddons/love2d/library"}
                    },
                    workspace = {
                      userThirdParty = {os.getenv("HOME") .. ".local/share/LuaAddons"},
                      checkThirdParty = "Apply"
                    }
                  }
                }
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
