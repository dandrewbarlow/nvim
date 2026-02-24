-- Avante: a seemingly well liked AI integration plugin

local localModel = {
      endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
      model = "qwen3:latest",
}

return {

  "yetone/avante.nvim",

  enabled = false,

  event = "VeryLazy",

  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.

  opts = {
    provider = "ollama",
    providers = {
      ollama = localModel,
    },

  },

  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      dependencies = {
        "bugaevc/wl-clipboard"
      },
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}

