-- aesthetics.lua
-- Andrew Barlow
--
-- for the finer things

return {
  {
    'Mofiqul/dracula.nvim',
    config = function()
      require('dracula').setup {
        vim.cmd.colorscheme('dracula'),
      }
    end
  },

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

  -- TPope: il papa
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive', -- git utilities
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
      "rcarriga/nvim-notify",
      }
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
