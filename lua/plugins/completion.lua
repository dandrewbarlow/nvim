return {
  {
    -- cmp: neovim completion engine
    "hrsh7th/nvim-cmp",
    dependencies = require('plugins.config.cmp').dependencies,
    config = require('plugins.config.cmp').config,

  }
}
