-- Alpha: Startup dashboard
-- Customized to add session support


return {
    'goolord/alpha-nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        -- import necessarary lua files to make things more concise
        local alpha = require('alpha')
        local theta = require('alpha.themes.theta')

        local dashboard = require('alpha.themes.dashboard')

        -- Starting here: the result of too much effort to create a custom section for sessions with mini.sessions
        local sessions_section = {
            type = "group",
            val = {
                { type = "padding", val = 2 },
                { type = "text", val = "Sessions", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
            },
            position = "center",
        }

        -- access list of sessions
        local mini_sessions = require('mini.sessions')
        local session_list = mini_sessions.detected

        -- loop through session list, and insert new buttons for them into sessions_section
        local i = 0
        for key, _ in pairs(session_list) do

            local button_map = "<leader>" .. tostring(i)
            local button_text = "  " .. key
            local cmd_string = "<cmd>lua MiniSessions.read(\"" .. tostring(key) .. "\")<CR>"

            local button = dashboard.button(button_map, button_text, cmd_string)

            table.insert(sessions_section.val, button)
          i = i+1
        end

        local custom_dash = theta

        -- table.insert(custom_dash, 7, { type = "text", val = "Sessions", opts = { hl = "SpecialComment", position = "center" } })
        -- table.insert(custom_dash.config.layout, { type = "padding, val = 2"})
        table.insert(custom_dash.config.layout, 5, sessions_section)

        alpha.setup(custom_dash.config)
    end
  }
