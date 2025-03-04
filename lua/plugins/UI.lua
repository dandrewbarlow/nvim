-- UI.lua
-- Andrew Barlow
--
-- User interface plugins

return {

  { -- Which-Key: preview key combo's effects
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = require('plugins.config.which_key').init,
    opts = require('plugins.config.which_key').opts,
    config = require('plugins.config.which_key').config,
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

  --[[ { -- vim-tmux-navigator: seamless vim+tmux navigation
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }, ]]
}
