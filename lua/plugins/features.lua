-- features.lua
-- Andrew Barlow
--
-- treats for a more civilized editor

return {

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

  { -- marks: improve functionality of vim marks
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function ()
      require("marks").setup({
        mappings = {
          next = 'mn',
          prev = 'mN',
        },
      })
    end
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

}
