-- plugins.lua
-- Andrew Barlow
--

-- Imports
-- local lsp = require('lsp')

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

  -- different plugin configs separated by their use case in plugins folder
  { import = "plugins" },
})
