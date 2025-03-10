
return {
  { -- Telescope: unlock the power of fuzzy finding
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = require('plugins.config.telescope').requires,
    config = require('plugins.config.telescope').config,
  },

  { -- telescope fzf util
    'nvim-telescope/telescope-fzf-native.nvim',
    -- need make, gcc installed, also have versions for cmake
    build = 'make',
  },

  { -- Oil: edit the filesystem like a buffer
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('oil').setup()
    end
  },

  { -- NeoTree: filetree viewer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = require('plugins.config.neotree').dependencies,
    init =  require('plugins.config.neotree').init,
  },
}
