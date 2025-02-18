return {

  -- when a directory is passed to vim as an argument, open neotree instead of Ex
  -- https://old.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))

      if stat and stat.type == "directory" then
        require("neo-tree").setup(
          { filesystem = { hijack_netrw_behavior = "open_current", }, }
        )
      end
    end
  end,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },

}
