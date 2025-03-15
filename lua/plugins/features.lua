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

  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
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

  {
    "kevinhwang91/nvim-bqf",
    config = function ()
      require('bqf').setup()
    end
  },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = function ()
      require('toggleterm').setup({
        hide_numbers = true,
        open_mapping = "<C-P>",
        insert_mappings = true,
        terminal_mappings = true,
      })
    end
  },

  require('plugins.config.mini'),

}
