-- keymaps.lua
-- Andrew Barlow


-- LEADER SHORTCUTS --------------------------------------------------

-- buffer management 
-- close tab
vim.keymap.set('n', '<leader>bd', '<cmd>:bd<CR>', {desc="[D]elete Buffer"})
-- create new tab
vim.keymap.set('n', '<leader>bn', '<cmd>:tabnew<CR>', {desc="[N]ew Buffer"})
-- next buffer
vim.keymap.set('n', '<Tab>', '<cmd>:BufferLineCycleNext<CR>')
-- previous buffer
vim.keymap.set('n', '<S-Tab>', '<cmd>:BufferLineCyclePrev<CR>')

-- Telescope (find) commands
-- file finding
vim.keymap.set('n', '<leader>ff', '<cmd>:Telescope find_files<CR>', {desc="[F]ind [F]iles"} )
-- grep this
vim.keymap.set('n', '<leader>fg', '<cmd>:Telescope live_grep<CR>', {desc="[F]ind w/ [G]rep"} )
-- command finding
vim.keymap.set('n', '<leader>fc', '<cmd>:Telescope commands<CR>', {desc="[F]ind [C]ommand"} )
-- manpage finding
vim.keymap.set('n', '<leader>fm', '<cmd>:Telescope man_pages<CR>', {desc="[F]ind [M]anual"} )
-- notification finding
vim.keymap.set('n', '<leader>fn', '<cmd>:Telescope notify<CR>', {desc="[F]ind [N]otification"} )
-- todo finding
vim.keymap.set('n', '<leader>ft', '<cmd>:TodoTelescope<CR>', {desc="[F]ind [T]odo's"} )
-- find buffer
vim.keymap.set('n', '<leader>fb', '<cmd>:Telescope buffers<CR>', {desc="[F]ind [B]uffer"})
-- help
vim.keymap.set('n', '<leader>fh', '<cmd>:Telescope help_tags<CR>', {desc="[F]ind [H]elp"} )
-- previous files
vim.keymap.set('n', '<leader>fp', '<cmd>:Telescope oldfiles<CR>', {desc="[F]ind [P]revious Files"} )

-- Commands to [S]how a panel (a [s]tretch)
-- Show todo's in a quick-fix panel
vim.keymap.set('n', '<leader>st', '<cmd>:TodoQuickFix<CR>', {desc="[S]how [T]odos"} )
-- show Trouble quickfix list
vim.keymap.set('n', '<leader>sq', '<cmd>:Trouble qflist toggle<CR>', {desc="[S]how [Q]uickfixes"} )
-- show trouble diagnostics
vim.keymap.set('n', '<leader>sd', '<cmd>:Trouble diagnostics toggle<CR>', {desc="[S]how [D]iagnostics"} )
-- show trouble symbols
vim.keymap.set('n', '<leader>ss', "<cmd>Trouble symbols toggle focus=false<cr>", {desc="[S]how [S]ymbols"} )
-- show trouble References
vim.keymap.set('n', '<leader>sr', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {desc="[S]how [R]eferences"} )
-- show trouble loclist
vim.keymap.set('n', '<leader>sl', "<cmd>Trouble loclist toggle<cr>", {desc="[S]how [L]ocation list"} )


-- Git
vim.keymap.set('n', '<leader>gs', '<cmd>:Git status<CR>', {desc="[G]it [S]tatus"} )
vim.keymap.set('n', '<leader>ga', '<cmd>:Git add .<CR>', {desc="[G]it [A]dd ."} )


-- TODO: commits w/ user input
-- Comments ? for some reason API is unneccesarily opaque, not sure how to call this
-- for now, it has default shortcuts of `gc_`
-- vim.keymap.set('v', '<leader>/', '?', {desc="Comment selection"} )
-- vim.keymap.set('n', '<leader>/', '?', {desc="Comment line"} )


-- aesthetic commands
-- colorscheme
vim.keymap.set('n', '<leader>ac', '<cmd>:Telescope colorscheme<CR>', {desc="[A]esthetic [C]olorschemes"} )

-- Mason
vim.keymap.set('n', '<leader>m', '<cmd>:Mason<CR>', {desc="[M]ason"} )

-- Lazy
vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<CR>', {desc="[L]azy"} )


-- terminal
vim.keymap.set('n', '<leader>t', '<cmd>:terminal<CR>', {desc="[T]erminal"} )

-- window management
-- vsplit
vim.keymap.set('n', '<leader>wv', '<cmd>:vsplit<CR>', {desc="[V]ertical Split"} )
-- hsplit
vim.keymap.set('n', '<leader>wh', '<cmd>:split<CR>', {desc="[H]orizontal Split"} )
-- close window
vim.keymap.set('n', '<leader>wc', '<cmd>:close<CR>', {desc="[C]lose"} )


-- toggle neotree
vim.keymap.set('n', '<leader>e', function()
  local reveal_file = vim.fn.expand('%:p')
  if (reveal_file == '') then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, "r")
    if (f) then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end
  require('neo-tree.command').execute({
    action = "focus",          -- OPTIONAL, this is the default value
    source = "filesystem",     -- OPTIONAL, this is the default value
    position = "left",         -- OPTIONAL, this is the default value
    toggle = true,
    reveal_file = reveal_file, -- path to file or folder to reveal
    reveal_force_cwd = true,   -- change cwd without asking if needed
  })
  end,
  { desc = "[E]xplorer" }
);

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- REGULAR KEYMAPS --------------------------------------------------

-- TODO: quick comment toggle
-- vim.keymap.set('n', '<leader>/', )

-- Save buffer
vim.keymap.set('n', '<C-s>', '<cmd>:w<CR>')
vim.keymap.set('i', '<C-s>', '<cmd>:w<CR>')
vim.keymap.set('i', '<C-s>', '<cmd>:w<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')




