-- Shamelessly lifted helper function
-- https://github.com/frans-johansson/lazy-nvim-starter/blob/main/.config/nvim/lua/helpers/keys.lua

local M = {}

M.map = function(mode, lhs, rhs, desc)
  if desc ~= "" then
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
  else
    vim.keymap.set(mode, lhs, rhs, { silent = true})
  end
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
	vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

M.dap_map = function(mode, lhs, rhs, desc)
	M.map(mode, lhs, rhs, desc)
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	M.map({ "n", "v" }, key, "<nop>")
end

return M
