return {
  -- MINI: a neat collection of plugins ---------------------------------------
  -- NOTE: mini recommends installing monorepo and enabling plugins you want. I
  -- am disobeying that recommendation.

  { -- mini.splitjoin: easily split args into multiple lines, or join into one
    -- default map: 'gS' to toggle
    'echasnovski/mini.splitjoin',
    version = false,
    config = function ()
      require('mini.splitjoin').setup()
    end
  },

  { -- mini.move: part of the mini.nvim library that allows you to easily move
    -- text around
    'echasnovski/mini.move',
    version = false,
    config = function ()
      require('mini.move').setup()
    end
  },

  {
    'echasnovski/mini.ai',
    version = false,
    config = function ()
      require('mini.ai').setup()
    end
  },

  {
    'echasnovski/mini.surround',
    version = false,
    config = function ()
      require('mini.surround').setup()
    end
  },

  {
    'echasnovski/mini.sessions',
    version = false,
    config = function ()
      require('mini.sessions').setup({
        directory = vim.fn.stdpath "data" .. "/sessions/"
      })
    end
  },

}
