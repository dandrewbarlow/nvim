-- features.lua
-- Andrew Barlow
--
-- treats for a more civilized editor

return {

  -- Git Integration --------------------------------------------------

  { -- GitSigns: Adds git related signs to the gutter, as well as utilities for
    -- managing changes
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

  { -- Neogit: the successor to TPope's fugitive git plugin
    "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua"
      },
      config = true
  },

  { -- LazyGit: Git TUI for the lazy
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {"nvim-lua/plenary.nvim",},

    -- setting the keybinding for LazyGit with 'keys' is recommended in order
    -- to load the plugin when the command is run for the first time
    keys = {{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" }}
  },


  -- UI --------------------------------------------------

  { -- Which-Key: preview key combo's effects
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = require('plugins.config.which_key').init,
    opts = require('plugins.config.which_key').opts,
    config = require('plugins.config.which_key').config, 
  },

  { -- Telescope: adds nice menu to some vim ops
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { 'nvim-lua/plenary.nvim', },
    config = require('plugins.config.telescope').config,
  },

  { -- telescope fzf util
    'nvim-telescope/telescope-fzf-native.nvim',
    -- need make, gcc installed, also have versions for cmake
    build = 'make',
  },

  { -- NeoTree: filetree viewer
    -- NOTE: oil.nvim is apparently the cool kid's preferred way to interact
    -- with files. May switch when bored.
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = require('plugins.config.neotree').dependencies,
    init =  require('plugins.config.neotree').init,
  },

  { -- help-vsplit.nvim: open help menu in a vsplit if there's enough room.
    -- personal preference
    'anuvyklack/help-vsplit.nvim',
    config = function ()
      require('help-vsplit').setup({
        always = false,
        side = 'right',
        buftype = { 'help' },
        filetype = { 'man' },
      })
    end

  },
  -- Coding Sugar --------------------------------------------------

  { -- Overseer: run build tasks
    'stevearc/overseer.nvim',
    opts = {},
    config = function ()
      require('overseer').setup()
    end
  },

  { -- Autopairs: automatically add complements of characters that come in
    -- pairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },

  { -- todo-comments: Highlights & adds quickfix list for TODO comments and
    -- more
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      require('todo-comments').setup()
    end
  },

  { -- Comment: toggle line comments
    'numToStr/Comment.nvim', opts = {}, lazy = false,
    config = function()
      -- custome comment toggling shortcuts 
      require('Comment').setup({
        toggler = {
          line = '<leader>/',
          block = '<leader>;',
        },
        opleader = {
          line = '<leader>/',
          block = '<leader>;',
        },
      })
    end
  },

  -- MINI: a neat collection of plugins ---------------------------------------
  -- NOTE: mini recommends installing monorepo and enabling plugins you want. I
  -- am disobeying that recommendation.

  { -- mini.splitjoin: easily split args into multiple lines, or join into one
    -- default map: 'gS' to toggle
    'echasnovski/mini.splitjoin',
    version = false,
    config = function ()
      require('mini.splitjoin').setup()
    end
  },

  { -- mini.move: part of the mini.nvim library that allows you to easily move
    -- text around
    'echasnovski/mini.move',
    version = false,
    config = function ()
      require('mini.move').setup()
    end
  },

  { -- formatter: install and use formatters to make files neater
    'stevearc/conform.nvim',
    opts = {},
    keys = require('plugins.config.conform').keys,
    config = require('plugins.config.conform').config,
  }
}
