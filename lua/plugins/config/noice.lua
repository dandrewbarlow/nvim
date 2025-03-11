-- Noice: folke's highly experimental UI overhaul
-- 

return {
    "folke/noice.nvim",

    event = "VeryLazy",

    opts = {
      -- add any options here
    },

    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",

      { -- nvim-notify: notification plugin
        "rcarriga/nvim-notify",
        config = function ()
          require('notify').setup(
            -- h: notify.config
            {
              render = "compact",
              stages = "fade",
            }
          )
        end
      },
    },

    config = function ()
      require('noice').setup({

        presets = {
          bottom_search = true,
          command_palette = true,
        },
        cmdline = {
          format = {
            help = { icon = '󰘥' },
            filter = { icon = '' },
            cmdline = { icon = '' },
          },
        },

        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        lualine_x = {
          {
            require("noice").api.status.message.get_hl,
            cond = require("noice").api.status.message.has,
          },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
        }
      })
    end
  }
