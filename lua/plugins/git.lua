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

}
