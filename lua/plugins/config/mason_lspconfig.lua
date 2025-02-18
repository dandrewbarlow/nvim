local config = function()
  local handlers = {

    -- general handler
    function (server_name)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('lspconfig')[server_name].setup {
        capabilities = capabilities
      }
    end,

    -- custom handlers
    -- BUG: I don't think this is getting called
    -- ['lua_ls'] = function ()
    --     local capabilities = require('cmp_nvim_lsp').default_capabilities()
    --     require('lspconfig')['lua_ls'].setup {
    --       capabilities = capabilities,
    --       -- add LuaAddons
    --       settings = {
    --         Lua = {
    --           library = {
    --             {os.getenv("HOME") .. ".local/share/LuaAddons/love2d/library"}
    --           },
    --           workspace = {
    --             userThirdParty = {os.getenv("HOME") .. ".local/share/LuaAddons"},
    --             checkThirdParty = "Apply"
    --           }
    --         }
    --       }
    --     }
    --
    -- end
  }

  require("mason-lspconfig").setup {
    automatic_installation = false,
    ensure_installed =  language_servers,
    handlers = handlers
  }


end

return config
