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

  -- alpha startup
  require('plugins.config.alpha'),

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

  -- snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = require('plugins.config.snacks').opts,

    init = require('plugins.config.snacks').init,
  },

  -- Noice: UI overhaul
  require('plugins.config.noice'),

  { -- zen-mode: cozy editing experience
    "folke/zen-mode.nvim",
    opts = {}
  },

  {
    "OxY2DEV/markview.nvim",
    lazy = false
  },

  -- lualine status bar
  require('plugins.config.lualine'),

}
