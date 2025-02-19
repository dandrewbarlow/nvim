return {

    dependencies = {
      -- hard deps
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',

      -- snippet engine
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- pretty icons
      'onsails/lspkind.nvim',
    },

    config = function()
      local cmp = require('cmp')
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      cmp.setup({

        -- snippet engine
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },

        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },

        -- keyboard mappings
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
        mapping = cmp.mapping.preset.insert({
          -- use tab to select next suggestion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- use shift+tab to select previous suggestion
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
               end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ select = false }),
          }),
        }),


        -- completion sources
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'lazydev' },
          },
          {
            { name = 'buffer' },
          }
        ),

        formatting = {
          format = lspkind.cmp_format(),
        }

        -- cmp.setup END
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

    end,
}
