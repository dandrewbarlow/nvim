return {

  -- sry tj, i'm lazy
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
  
  -- BUG: tbh idk exactly how this works, idk if it's busted or working as intended. Thought it would be cool, no problems if u just don't use it tho
  --
  -- kitty scrollback buffer integration
  -- https://sw.kovidgoyal.net/kitty/overview/#the-scrollback-buffer
  -- requires changes to kitty.conf:
  -- https://github.com/mikesmithgh/kitty-scrollback.nvim?tab=readme-ov-file#%EF%B8%8F-setup
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    event = { 'User KittyScrollbackLaunch' },
    version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
  }

}
