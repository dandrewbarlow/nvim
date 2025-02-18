-- aesthetics.lua
-- Andrew Barlow
--
-- for the finer things

return {
  -- COLORSCHEMES --------------------------------------------------

  { -- goated colorscheme
    'Mofiqul/dracula.nvim',
    config = function()
      -- this line sets dracula to default colorscheme
      require('dracula').setup {
        vim.cmd.colorscheme('dracula'),
      }
    end
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "folke/tokyonight.nvim", priority = 1000 },

  { "sainnhe/gruvbox-material", name="gruvbox", priority=1000 },


  { "shaunsingh/nord.nvim", name="nord", priority=1000},


  -- PRETTY FEATURES --------------------------------------------------
  { -- Alpha: Startup dashboard
    'goolord/alpha-nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.theta'.config)
    end
  };

  { --TreeSitter: syntax highlighting
    -- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = { 'c', 'lua', 'vim', 'markdown', 'markdown_inline', 'javascript', },

        auto_install = true
      }
    end
  },

  { -- Treesitter Context: shows context of code
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
      require("treesitter-context").setup()
    end
  },

  { -- Bufferline: adds a buffer viewer
    'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup()
    end
  },

  { -- neoscroll: smooth scrolling
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup({
        -- options: 
        ----------------
        -- linear
        -- quadratic
        -- cubic
        -- quartic
        -- quintic
        -- circular
        -- sine
        easing = 'cubic'
      })
    end
  },

  -- TPope: il papa
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-surround', -- tools to mess with surrounding brackets/quotes/etc

  -- dressing: adds some finesse to nvim UI
  {"stevearc/dressing.nvim", opts = {}},

  -- Noice: UI overhaul
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback

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
  },


  { -- Lualine: statusline plugin
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    options = {theme = 'dracula'},
    config = function()
      require('lualine').setup {
        options = {
          theme = 'dracula'
        }
      }
    end,
  },
}


--[ TODO: get rid of triangles in lualine
--
--
--  icons_enabled = true,
--  theme = 'auto',
--  component_separators = { left = '', right = ''},
--  section_separators = { left = '', right = ''},
--  disabled_filetypes = {
--    statusline = {},
--    winbar = {},
--
--
--
--
--]
