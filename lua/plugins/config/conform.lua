return {
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>bf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "[F]ormat Buffer",
    },
  },

  config = function ()
    require('conform').setup({
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      }
    })
  end
}
