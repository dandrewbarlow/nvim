-- keymaps.lua
-- Andrew Barlow

local map = require('helpers.keys').map

-- KEY DELETION --------------------------------------------------

-- conflicts with my surround plugin, don't really use this anyway
-- TODO: see if there is a way to disable the timeout that's still messing w/ surround mappings without implementing globally
map('n', 's', "<Nop>", "")

-- LEADER SHORTCUTS --------------------------------------------------
----------------------------------------------------------------------

-- BUFFER MANAGEMENT --------------------------------------------------

-- close tab
map('n', '<leader>bd', '<cmd>:bd<cr>', "[D]elete buffer")
-- kill tab
map('n', '<leader>bk', '<cmd>:bd!<cr>', "[k]ill buffer")
-- create new tab
map('n', '<leader>bn', '<cmd>:tabnew<CR>', "[N]ew Buffer")
-- next buffer
map('n', '<Tab>', '<cmd>:BufferLineCycleNext<CR>')
-- previous buffer
map('n', '<S-Tab>', '<cmd>:BufferLineCyclePrev<CR>')


-- TELESCOPE (FIND) COMMANDS --------------------------------------------------

-- file finding
map('n', '<leader>ff', '<cmd>:Telescope fd<CR>', "[F]iles" )
-- grep this
map('n', '<leader>fg', '<cmd>:Telescope live_grep<CR>', "[G]rep" )
-- command finding
map('n', '<leader>fc', '<cmd>:Telescope commands<CR>', "[C]ommand" )
-- telescope menu
map('n', '<leader>fs', '<cmd>Telescope<CR>', "Tele[S]cope")
-- manpage finding
map('n', '<leader>fm', '<cmd>:Telescope man_pages<CR>', "[M]anual" )
-- notification finding
map('n', '<leader>fn', '<cmd>:Telescope notify<CR>', "[N]otification" )
-- todo finding
map('n', '<leader>ft', '<cmd>:TodoTelescope<CR>', "[T]odo's" )
-- find buffer
map('n', '<leader>fb', '<cmd>:Telescope buffers<CR>', "[B]uffer")
-- help
map('n', '<leader>fh', '<cmd>:Telescope help_tags<CR>', "[H]elp" )
-- previous files
map('n', '<leader>fp', '<cmd>:Telescope oldfiles<CR>', "[P]revious Files" )
-- spelling suggestions
map('n', '<leader>fr', '<cmd>:Telescope spell_suggest<CR>', "Spelling [R]eccomendation" )

-- RUN COMMANDS --------------------------------------------------

-- overseer run
map('n', '<leader>rr', '<cmd>OverseerRun<CR>', "[R]un")
-- overseer build
map('n', '<leader>rb', '<cmd>OverseerBuild<CR>', "[B]uild")
-- overseer save
map('n', '<leader>rs', '<cmd>OverseerSaveBundle<CR>', "[S]ave Bundle")
-- overseer load
map('n', '<leader>rl', '<cmd>OverseerLoadBundle<CR>', "[L]oad Bundle")
-- overseer action
map('n', '<leader>ra', '<cmd>OverseerQuickAction<CR>', "[A]ction")

-- CREATE COMMANDS --------------------------------------------------
map('n', '<leader>cd', '<cmd>Neogen<CR>', '[D]ocumentation')

-- OPEN COMANDS --------------------------------------------------

-- Show todo's in a quick-fix panel
map('n', '<leader>ot', '<cmd>:TodoQuickFix<CR>', "[T]odos" )
-- show Trouble quickfix list
map('n', '<leader>oq', '<cmd>:Trouble qflist toggle<CR>', "[Q]uickfixes" )
-- show trouble diagnostics
map('n', '<leader>od', '<cmd>:Trouble diagnostics toggle<CR>', "[D]iagnostics" )
-- show trouble symbols
map('n', '<leader>os', "<cmd>Trouble symbols toggle focus=false<cr>", "[S]ymbols" )
-- show trouble References
map('n', '<leader>or', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "[R]eferences" )
-- show trouble loclist
map('n', '<leader>ol', "<cmd>Trouble loclist toggle<cr>", "[L]ocation List" )
-- show markdown preview
map('n', '<leader>om', "<cmd>Markview<cr>", "[M]arkdown Preview Toggle" )
-- show overseer
map('n', '<leader>oo', "<cmd>OverseerToggle<cr>", "[O]verseer" )
-- show undotree
map('n', "<leader>ou", "<cmd>lua require('undotree').toggle()<cr>", "[U]ndoTree" )

-- DEBUG COMMANDS --------------------------------------------------
-- debug toggle UI
map('n', '<leader>dt', "<cmd>lua require('dapui').toggle()<CR>", "[T]oggle" )

map('n', '<leader>dc', function() require('dap').continue() end, "[C]ontinue")
map('n', '<leader>do', function() require('dap').step_over() end, "Step [o]ver")
map('n', '<leader>di', function() require('dap').step_into() end, "Step [i]nto")
map('n', '<leader>dO', function() require('dap').step_out() end, "Step [O]ut")
map('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, "toggle [b]reakpoint")
map('n', '<Leader>dB', function() require('dap').set_breakpoint() end, "set [B]reakpoint")
map('n', '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "set [l]og breakpoint")
map('n', '<Leader>dr', function() require('dap').repl.open() end, "open [r]epl")
map('n', '<Leader>dL', function() require('dap').run_last() end, "run [L]ast")
map({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, "[h]over")

map({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, "[p]review")

map('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, "[f]loat")

map('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, "[s]copes")


-- GIT --------------------------------------------------

map('n', '<leader>gs', '<cmd>:Neogit<CR>', "[S]tatus" )
map('n', '<leader>ga', '<cmd>:Neogit add .<CR>', "[A]dd ." )

-- AESTHETIC COMMANDS --------------------------------------------------

-- colorscheme
map('n', '<leader>ac', '<cmd>:Telescope colorscheme<CR>', "[C]olorschemes" )
-- zen mode
map('n', '<leader>az', '<cmd>:ZenMode<CR>', "[Z]en" )

-- PLUGIN MANAGEMENT --------------------------------------------------
-- mason --------------------------------------------------
map('n', '<leader>pm', '<cmd>:Mason<CR>', "[M]ason" )
-- lazy --------------------------------------------------
map('n', '<leader>pl', '<cmd>:Lazy<CR>', "[L]azy" )

-- MARKS --------------------------------------------------
-- show marks
map('n', '<leader>ml', '<cmd>MarksListAll<CR>', "[L]ist" )
-- find marks
map('n', '<leader>mf', '<cmd>Telescope marks<CR>', "[F]ind" )
-- next mark
map('n', '<leader>mn', '<Plug>(Marks-next)<CR>', "[N]ext" )
-- prev mark
map('n', '<leader>mN', '<Plug>(Marks-prev)<CR>', "Previous" )


-- TERMINAL --------------------------------------------------

-- see toggleterm in plugins/features.lua
-- term mappings

map('t', '<esc><esc>', "<C-\\><C-n>", "")
map('t', '<C-h>', "<Cmd>wincmd h<CR>", "")
map('t', '<C-j>', "<Cmd>wincmd j<CR>", "")
map('t', '<C-k>', "<Cmd>wincmd k<CR>", "")
map('t', '<C-l>', "<Cmd>wincmd l<CR>", "")
map('t', '<C-w>', "<C-\\><C-n><C-w>", "")


-- WINDOW MANAGEMENT --------------------------------------------------

-- vsplit
map('n', '<leader>wv', '<cmd>:vsplit<CR>', "[V]ertical Split" )
-- hsplit
map('n', '<leader>wh', '<cmd>:split<CR>', "[H]orizontal Split" )
-- close window
map('n', '<leader>wc', '<cmd>:close<CR>', "[C]lose" )


-- NEOTREE --------------------------------------------------
map('n', '<leader>e', function()
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
    "[E]xplorer"
);

-- SESSION MANAGEMENT ---------------------------------------------------
-- Kinda a pain to set up but at least I'm learning some lua

local function check_sessions()
  local session_list = {}
  local i = 1

  for key, _ in pairs(MiniSessions.detected) do
    session_list[i] = key
    i = i+1
  end

  if #session_list ~= 0 then
    return true
  else
    vim.notify("No Sessions Detected", vim.log.levels.WARN)
    return false
  end
end

-- save session
map(
  'n',
  '<leader>ss',
  function ()
    vim.ui.input({
        prompt="Enter Session Name",
        default = vim.fn.getcwd(),
      },

      function (input)
        if (input ~= "") then
          MiniSessions.write(input)
        end
      end
    )

  end,
  "Save Session"
)

-- load session
map(
  'n',
  '<leader>sl',
  function ()
    if check_sessions() then
      MiniSessions.select("read")
    end
  end,
  "Load Session"
)

-- delete sessions
map(
  'n',
  '<leader>sd',
  function ()
    if check_sessions() then
      MiniSessions.select("delete")
    end
  end,
  "Delete Session"
)


-- REGULAR KEYMAPS --------------------------------------------------
---------------------------------------------------------------------

-- Oil
map("n", "-", "<CMD>Oil<CR>",   "Open parent directory" )

-- resize windows
map('n', '<C-->', '<CMD>resize -1<CR>', "decrease window height")
map('n', '<C-=>', '<CMD>resize +1<CR>', "increase window height")
map('n', '<C-,>', '<CMD>vertical resize -1<CR>', "increase window width")
map('n', '<C-.>', '<CMD>vertical resize +1<CR>', "decrease window width")

-- Save buffer
map({'n', 'i', 'v'}, '<C-s>', '<cmd>:w<CR>')

-- quit
map('n', '<leader>q', '<cmd>:q<CR>', "[Q]uit")

-- go to last cursor position
map('n', 'gl', '``', "last position")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', 'Move focus to the left window' )
map('n', '<C-l>', '<C-w><C-l>', 'Move focus to the right window' )
map('n', '<C-j>', '<C-w><C-j>', 'Move focus to the lower window' )
map('n', '<C-k>', '<C-w><C-k>', 'Move focus to the upper window' )

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')




