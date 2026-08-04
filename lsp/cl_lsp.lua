-- cl_lsp.lua
-- Andrew Barlow
--
-- Common Lisp language server. cxxxr/cl-lsp is a thin roswell wrapper around
-- lem-language-server (from the Lem editor), which speaks stdio by default.
--
-- No mason package exists for it, so install by hand:
--   pacman -S roswell sbcl
--   ros install lem-project/lem cxxxr/cl-lsp
--
-- Enabling is gated on the binary existing -- see helpers.tooling.enable_manual
-- and the manual_lsp_list in plugins/config/lsp.lua.

-- prefer $PATH, fall back to roswell's bin dir so a GUI-launched nvim (which
-- never sourced env.zsh) still finds the server
local function cl_lsp_cmd()
  if vim.fn.executable('cl-lsp') == 1 then
    return 'cl-lsp'
  end
  return vim.fn.expand('~/.roswell/bin/cl-lsp')
end

return {
  cmd = { cl_lsp_cmd() },
  filetypes = { 'lisp' },

  -- root_markers only matches exact filenames, but a CL project is identified
  -- by a *.asd system definition, so resolve the root by hand.
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(fname)

    local asd = vim.fs.find(function(name)
      return name:match('%.asd$') ~= nil
    end, { upward = true, path = dir })[1]

    on_dir(asd and vim.fs.dirname(asd) or vim.fs.root(bufnr, { '.git' }) or dir)
  end,
}
