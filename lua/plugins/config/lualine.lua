-- Lualine: statusline plugin

return {
    'nvim-lualine/lualine.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    options = {theme = 'dracula'},

    config = function()

      -- show macro recording feedback on statusline
      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()

        if recording_register == "" then
          return ""
        else
          return " Recording @" .. recording_register
        end
      end

      local function macro_recording_color()
          -- terse form of: 
          -- nil if not recording macro else:
          -- use Error highlight group to get pretty red recording statusbar
          return show_macro_recording() ~= "" and nil or 'Error'
      end

      -- I'm just having fun now
      local function fileIcon()
        local lsp_is_attatched = vim.lsp.buf_is_attached(0, vim.lsp.get_clients({bufnr=0})[1].id)
        return lsp_is_attatched and '󰈔' or nil
      end

      -- :h lualine-usage-and-customization
      require('lualine').setup {
        options = {
          theme = 'dracula',
          component_separators = '|',
          section_separators = '',
          },
        sections = {
          lualine_a = {
            'mode',
            {
              -- Display macro recording info in statusbar
              show_macro_recording,
              color = macro_recording_color()
            },

          },
          lualine_c = {
            {
              fileIcon,
              separator = ""
            },
            {
              'filename',
            },
          }
        },
      }
    end,
  }
