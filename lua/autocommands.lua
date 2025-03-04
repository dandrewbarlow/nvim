-- autocommands.lua
-- Andrew Barlow
--
-- NVIM autocommands (mostly taken from kickstart.nvim, learn something new
-- every day)
-- --------------------------------------------------

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- LSP --------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.supports_method('textDocument/rename') then
      -- Rename var keymap
      vim.keymap.set('n', '<leader>lr', '<CMD> lua vim.lsp.buf.rename()<CR>', {desc ="Rename"})
    end

    if client.supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation
      vim.keymap.set('n', '<leader>li', '<CMD> lua vim.lsp.buf.implementation()<CR>', {desc ="Implementation"})
    end

    -- code action
    vim.keymap.set('n', '<leader>la', '<CMD> lua vim.lsp.buf.code_action()<CR>', {desc ="Code Action"})

    -- show lsp info
    vim.keymap.set('n', '<leader>li', '<CMD>LspInfo<CR>', {desc="LSP Info"})
  end,
})

