-- git.lua
-- Andrew Barlow
--
-- Git Integration plugins

return {

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

}
