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

        -- sorter function, working with my custom array below and the MiniSessions.detected.modify_time property
        local sorter = function(session_a, session_b)
            return session_a[2].modify_time > session_b[2].modify_time
        end

        -- create a new list, holding the key, and value in their own array
        local sorted_session_list = {}
        for k, j in pairs(session_list) do
            local el = {k, j}
            table.insert(sorted_session_list, el)
        end

        -- sort the new list by most recently used
        table.sort(sorted_session_list, sorter)

        -- -- loop through session list, and insert new buttons for them into sessions_section

        for index, value in ipairs(sorted_session_list) do

            local button_map = "<leader>" .. tostring(index-1)
            local button_text = "  " .. value[1]
            local cmd_string = "<cmd>lua MiniSessions.read(\"" .. tostring(value[1]) .. "\")<CR>"

            local button = dashboard.button(button_map, button_text, cmd_string)

            table.insert(sessions_section.val, button)
        end

        local custom_dash = theta

        -- table.insert(custom_dash, 7, { type = "text", val = "Sessions", opts = { hl = "SpecialComment", position = "center" } })
        -- table.insert(custom_dash.config.layout, { type = "padding, val = 2"})
        table.insert(custom_dash.config.layout, 5, sessions_section)

        alpha.setup(custom_dash.config)
    end
  }
