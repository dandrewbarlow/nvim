local M = {}

M.init = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
end

M.opts = {

  ---@type false | "classic" | "modern" | "helix"
  preset = "classic",

  -- local order group alphanum mod
  sort = "local",

  -- prefix names
  groups = {
    {"<leader>a", group = '[A]rtificial Intelligence'},
    {"<leader>b", group = '[B]uffer'},
    {"<leader>c", group = '[C]reate'},
    {"<leader>d", group = '[D]ebug'},
    {"<leader>f", group = '[F]ind'},
    {"<leader>g", group = '[G]it'},
    {"<leader>l", group = '[L]SP'},
    {"<leader>m", group = '[M]arks'},
    {"<leader>o", group = '[O]pen'},
    {"<leader>p", group = '[P]lugins'},
    {"<leader>r", group = '[R]un'},
    {"<leader>s", group = '[S]ession'},
    {"<leader>w", group = '[W]indow'},
  },
}

M.config = function(_, opts)
  local wk = require('which-key')
  wk.add(opts.groups)
end

return M
