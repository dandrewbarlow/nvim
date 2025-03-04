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
vim.keymap.set('n', '<leader>ff', '<cmd>:Telescope fd<CR>', {desc="[F]iles"} )
-- grep this
vim.keymap.set('n', '<leader>fg', '<cmd>:Telescope live_grep<CR>', {desc="[G]rep"} )
-- command finding
vim.keymap.set('n', '<leader>fc', '<cmd>:Telescope commands<CR>', {desc="[C]ommand"} )
-- telescope menu
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope<CR>', {desc="Tele[S]cope"})
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
-- spelling suggestions
vim.keymap.set('n', '<leader>fr', '<cmd>:Telescope spell_suggest<CR>', {desc="Spelling [R]eccomendation"} )

-- RUN COMMANDS --------------------------------------------------

-- overseer run
vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR>', {desc="[R]un"})
-- overseer build
vim.keymap.set('n', '<leader>rb', '<cmd>OverseerBuild<CR>', {desc="[B]uild"})
-- overseer save
vim.keymap.set('n', '<leader>rs', '<cmd>OverseerSaveBundle<CR>', {desc="[S]ave Bundle"})
-- overseer load
vim.keymap.set('n', '<leader>rl', '<cmd>OverseerLoadBundle<CR>', {desc="[L]oad Bundle"})
-- overseer action
vim.keymap.set('n', '<leader>ra', '<cmd>OverseerQuickAction<CR>', {desc="[A]ction"})

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

-- DEBUG COMMANDS --------------------------------------------------
-- debug toggle UI
vim.keymap.set('n', '<leader>dt', "<cmd>lua require('dapui').toggle()<CR>", {desc="[T]oggle"} )


vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, {desc="[C]ontinue"})
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, {desc="Step [o]ver"})
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, {desc="Step [i]nto"})
vim.keymap.set('n', '<leader>dO', function() require('dap').step_out() end, {desc="Step [O]ut"})
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, {desc="toggle [b]reakpoint"})
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, {desc="set [B]reakpoint"})
vim.keymap.set('n', '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc="set [l]og breakpoint"})
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, {desc="open [r]epl"})
vim.keymap.set('n', '<Leader>dL', function() require('dap').run_last() end, {desc="run [L]ast"})
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, {desc="[h]over"})
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, {desc="[p]review"})
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, {desc="[f]loat"})
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, {desc="[s]copes"})


-- GIT --------------------------------------------------

vim.keymap.set('n', '<leader>gs', '<cmd>:Neogit<CR>', {desc="[S]tatus"} )
vim.keymap.set('n', '<leader>ga', '<cmd>:Neogit add .<CR>', {desc="[A]dd ."} )

-- AESTHETIC COMMANDS --------------------------------------------------

-- colorscheme
vim.keymap.set('n', '<leader>ac', '<cmd>:Telescope colorscheme<CR>', {desc="[C]olorschemes"} )
-- zen mode
vim.keymap.set('n', '<leader>az', '<cmd>:ZenMode<CR>', {desc="[Z]en"} )

-- PLUGIN MANAGEMENT --------------------------------------------------
-- mason --------------------------------------------------
vim.keymap.set('n', '<leader>pm', '<cmd>:Mason<CR>', {desc="[M]ason"} )
-- lazy --------------------------------------------------
vim.keymap.set('n', '<leader>pl', '<cmd>:Lazy<CR>', {desc="[L]azy"} )

-- MARKS --------------------------------------------------
-- show marks
vim.keymap.set('n', '<leader>ml', '<cmd>MarksListAll<CR>', {desc="[L]ist"} )
-- find marks
vim.keymap.set('n', '<leader>mf', '<cmd>Telescope marks<CR>', {desc="[F]ind"} )
-- next mark
vim.keymap.set('n', '<leader>mn', '<Plug>(Marks-next)<CR>', {desc="[N]ext"} )
-- prev mark
vim.keymap.set('n', '<leader>mN', '<Plug>(Marks-prev)<CR>', {desc="Previous"} )


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

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- resize windows
vim.keymap.set('n', '<C-->', '<CMD>resize -1<CR>', {desc = "decrease window height"})
vim.keymap.set('n', '<C-=>', '<CMD>resize +1<CR>', {desc = "increase window height"})
vim.keymap.set('n', '<C-,>', '<CMD>vertical resize -1<CR>', {desc = "increase window width"})
vim.keymap.set('n', '<C-.>', '<CMD>vertical resize +1<CR>', {desc = "decrease window width"})

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




