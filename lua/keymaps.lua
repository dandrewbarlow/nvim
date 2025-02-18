-- keymaps.lua
-- Andrew Barlow


-- LEADER SHORTCUTS --------------------------------------------------
----------------------------------------------------------------------

-- BUFFER MANAGEMENT --------------------------------------------------

-- close tab
vim.keymap.set('n', '<leader>bd', '<cmd>:bd<cr>', {desc="[D]elete buffer"})
-- kill tab
vim.keymap.set('n', '<leader>bk', '<cmd>:bd!<cr>', {desc="[k]ill buffer"})
-- create new tab
vim.keymap.set('n', '<leader>bn', '<cmd>:tabnew<CR>', {desc="[N]ew Buffer"})
-- next buffer
vim.keymap.set('n', '<Tab>', '<cmd>:BufferLineCycleNext<CR>')
-- previous buffer
vim.keymap.set('n', '<S-Tab>', '<cmd>:BufferLineCyclePrev<CR>')

-- TELESCOPE (FIND) COMMANDS --------------------------------------------------

-- file finding
vim.keymap.set('n', '<leader>ff', '<cmd>:Telescope find_files<CR>', {desc="[F]iles"} )
-- grep this
vim.keymap.set('n', '<leader>fg', '<cmd>:Telescope live_grep<CR>', {desc="[G]rep"} )
-- command finding
vim.keymap.set('n', '<leader>fc', '<cmd>:Telescope commands<CR>', {desc="[C]ommand"} )
-- manpage finding
vim.keymap.set('n', '<leader>fm', '<cmd>:Telescope man_pages<CR>', {desc="[M]anual"} )
-- notification finding
vim.keymap.set('n', '<leader>fn', '<cmd>:Telescope notify<CR>', {desc="[N]otification"} )
-- todo finding
vim.keymap.set('n', '<leader>ft', '<cmd>:TodoTelescope<CR>', {desc="[T]odo's"} )
-- find buffer
vim.keymap.set('n', '<leader>fb', '<cmd>:Telescope buffers<CR>', {desc="[B]uffer"})
-- help
vim.keymap.set('n', '<leader>fh', '<cmd>:Telescope help_tags<CR>', {desc="[H]elp"} )
-- previous files
vim.keymap.set('n', '<leader>fp', '<cmd>:Telescope oldfiles<CR>', {desc="[P]revious Files"} )

-- RUN COMMANDS --------------------------------------------------

-- overseer run
vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR>', {desc="[R]un"})
-- overseer build
vim.keymap.set('n', '<leader>rb', '<cmd>OverseerBuild<CR>', {desc="[B]uild"})

-- SHOW COMANDS --------------------------------------------------

-- Show todo's in a quick-fix panel
vim.keymap.set('n', '<leader>st', '<cmd>:TodoQuickFix<CR>', {desc="[T]odos"} )
-- show Trouble quickfix list
vim.keymap.set('n', '<leader>sq', '<cmd>:Trouble qflist toggle<CR>', {desc="[Q]uickfixes"} )
-- show trouble diagnostics
vim.keymap.set('n', '<leader>sd', '<cmd>:Trouble diagnostics toggle<CR>', {desc="[D]iagnostics"} )
-- show trouble symbols
vim.keymap.set('n', '<leader>ss', "<cmd>Trouble symbols toggle focus=false<cr>", {desc="[S]ymbols"} )
-- show trouble References
vim.keymap.set('n', '<leader>sr', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {desc="[R]eferences"} )
-- show trouble loclist
vim.keymap.set('n', '<leader>sl', "<cmd>Trouble loclist toggle<cr>", {desc="[L]ocation List"} )
-- show markdown preview
vim.keymap.set('n', '<leader>sm', "<cmd>Markview<cr>", {desc="[M]arkdown Preview Toggle"} )
-- show overseer
vim.keymap.set('n', '<leader>so', "<cmd>OverseerToggle<cr>", {desc="[O]verseer"} )


-- GIT --------------------------------------------------

vim.keymap.set('n', '<leader>gs', '<cmd>:Neogit<CR>', {desc="[S]tatus"} )
vim.keymap.set('n', '<leader>ga', '<cmd>:Neogit add .<CR>', {desc="[A]dd ."} )

-- AESTHETIC COMMANDS --------------------------------------------------

-- colorscheme
vim.keymap.set('n', '<leader>ac', '<cmd>:Telescope colorscheme<CR>', {desc="[C]olorschemes"} )
-- zen mode
vim.keymap.set('n', '<leader>az', '<cmd>:ZenMode<CR>', {desc="[Z]en"} )

-- MASON --------------------------------------------------
vim.keymap.set('n', '<leader>m', '<cmd>:Mason<CR>', {desc="[M]ason"} )

-- LAZY --------------------------------------------------
vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<CR>', {desc="[L]azy"} )


-- TERMINAL --------------------------------------------------
vim.keymap.set('n', '<leader>t', '<cmd>:terminal<CR>', {desc="[T]erminal"} )
-- floating terminal toggle
vim.keymap.set({'n', 't'}, '<C-Space>', '<cmd>:Floaterminal<CR>', {desc="Floating Terminal Toggle"} )


-- WINDOW MANAGEMENT --------------------------------------------------

-- vsplit
vim.keymap.set('n', '<leader>wv', '<cmd>:vsplit<CR>', {desc="[V]ertical Split"} )
-- hsplit
vim.keymap.set('n', '<leader>wh', '<cmd>:split<CR>', {desc="[H]orizontal Split"} )
-- close window
vim.keymap.set('n', '<leader>wc', '<cmd>:close<CR>', {desc="[C]lose"} )


-- NEOTREE --------------------------------------------------
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


-- REGULAR KEYMAPS --------------------------------------------------
---------------------------------------------------------------------

-- Save buffer
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<cmd>:w<CR>')

-- quit
vim.keymap.set('n', '<leader>q', '<cmd>:q<CR>', {desc="[Q]uit"})


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




