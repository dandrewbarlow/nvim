local M = {}


M.requires = {
  'nvim-lua/plenary.nvim',
}

M.opts = {}

M.config = function()

  local actions = require('telescope.actions')

  -- just to avoid duplicating for normal and insert mode
  local my_mappings = {
    ["<C-j>"] = { 
      actions.move_selection_next,
      type = "action",
      opts = { nowait = true, silent = true }
    },

    ["<C-k>"] = { 
      actions.move_selection_previous,
      type = "action",
      opts = { nowait = true, silent = true }
    }
  }

  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    },

    defaults = {
      mappings = {
        i = my_mappings,
        n = my_mappings
      }
    }

  }

  -- enable telescope fuzzy finding
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('noice')
end

return M
