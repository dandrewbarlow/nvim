-- plugins.lua
-- Andrew Barlow
--

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({

  -- FEATURES --------------------------------------------------

  { -- Which-Key
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,

    opts = {
      groups = { -- prefix names
        {"<leader>b", group = '[B]uffer'},
        {"<leader>g", group = '[G]it'},
        {"<leader>f", group = '[F]ind'},
        --{"<leader>/", group = '[C]omment'},
        --{"<leader>h", group = 'Check [H]ealth'},
      },
    },

    config = function(_, opts)
      local wk = require('which-key')
      wk.add(opts.groups)
    end

  },

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- GitSigns: Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Telescope: adds nice menu to some vim ops
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { 'nvim-lua/plenary.nvim' }
  },

  { -- NeoTree: filetree viewer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    -- when a directory is passed to vim as an argument, open neotree instead of Ex
    -- https://old.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
    init = function() 
      if vim.fn.argc(-1) == 1 then 
        local stat = vim.loop.fs_stat(vim.fn.argv(0)) 

        if stat and stat.type == "directory" then 
          require("neo-tree").setup(
            { filesystem = { hijack_netrw_behavior = "open_current", }, }
          ) 
        end 
      end
    end
  },

  { -- Autopairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('todo-comments').setup()
    end
  },

  { -- Comment
    'numToStr/Comment.nvim', opts = {}, lazy = false,
    config = function()
      require('Comment').setup()
    end
  },

  -- AESTHETICS --------------------------------------------------
  
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

  -- vim-sleuth
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

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

  -- LSP CONFIGS --------------------------------------------------

  { -- Mason: LSP manager
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
})
