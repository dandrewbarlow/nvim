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

  { -- for working with binary/hex data
    'RaafatTurki/hex.nvim',
    config = function()
      require('hex').setup {
        dump_cmd = 'xxd -g 1 -u -b'
      }
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

  { -- swapdiff: diff view of swapfile changes for more helpful recovery
    'trippwill/swapdiff.nvim',
  },

  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
  },

  --- better quickfix menu
  {
    "kevinhwang91/nvim-bqf",
    config = function ()
      require('bqf').setup()
    end
  },

  --- make undo commands more complicated
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },

  require('plugins.config.mini'),

}
