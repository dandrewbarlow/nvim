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

-- https://oneofone.dev/post/neovim-diagnostics-float/
-- diagnostic floating lines
local group = vim.api.nvim_create_augroup('OoO', {})

local function au(typ, pattern, cmdOrFn)
	if type(cmdOrFn) == 'function' then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

au({ 'CursorHold', 'InsertLeave' }, nil, function()
	local opts = {
		focusable = false,
		scope = 'cursor',
		close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
	}
	vim.diagnostic.open_float(nil, opts)
end)

au('InsertEnter', nil, function()
	vim.diagnostic.enable(false)
end)

au('InsertLeave', nil, function()
	vim.diagnostic.enable(true)
end)


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
    -- lsp_map scopes these to the attached buffer. plain map() would set them
    -- globally, so they'd follow you into buffers with no LSP -- and shadow
    -- conjure, which shares the <leader>l prefix (see plugins/config/lisp.lua).
    local lsp_map = require('helpers.keys').lsp_map

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end

    if client:supports_method('textDocument/rename') then
      -- Rename var keymap
      lsp_map('<leader>lr', '<CMD> lua vim.lsp.buf.rename()<CR>', args.buf, "Rename")
    end

    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation
      lsp_map('<leader>li', '<CMD> lua vim.lsp.buf.implementation()<CR>', args.buf, "Implementation")
    end

    if client:supports_method('textDocument/definition') then
      lsp_map('<leader>ld', '<CMD> lua vim.lsp.buf.definition()<CR>', args.buf, "Definition")
      lsp_map('gd', '<CMD> lua vim.lsp.buf.definition()<CR>', args.buf, "Definition")
    end
    -- code action
    lsp_map('<leader>la', '<CMD> lua vim.lsp.buf.code_action()<CR>', args.buf, "Code Action")

    -- show lsp info
    lsp_map('<leader>lI', '<CMD>LspInfo<CR>', args.buf, "LSP Info")
  end,
})

