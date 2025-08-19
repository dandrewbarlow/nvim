-- Alpha: Startup dashboard
-- Customized to add session support

local header = {
[[          ___   ____                    ]],
[[        /' --;^/ ,-_\     \ | /                    ]],
[[       / / --o\ o-\ \\   --(_)--                    ]],
[[      /-/-/|o|-|\-\\|\\   / | \                    ]],
[[       '`  ` |-|   `` '                    ]],
[[             |-|                    ]],
[[             |-|O                    ]],
[[             |-(\,__                    ]],
[[          ...|-|\--,\_....                    ]],
[[      ,;;;;;;;;;;;;;;;;;;;;;;;;,.                    ]],
[[~~,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    ]],
[[~;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,  ______   ---------   _____     ------                    ]]
}

-- let me go back to default header easily
local replace_header = true

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
        local function create_custom_section(name)
            return {
                type = "group",
                val = {
                    { type = "padding", val = 2 },
                    { type = "text", val = name, opts = { hl = "SpecialComment", position = "center" } },
                    { type = "padding", val = 1 },
                },
                position = "center",
            }
        end

        local custom_section

        -- access list of sessions
        local mini_sessions = require('mini.sessions')
        local session_list = mini_sessions.detected
        local custom_dash = theta

        if replace_header then
            custom_dash.header.val = header
        end

        -- TODO: list relevant files in local dir

        -- chech if there are any sessions
        if next(session_list) ~= nil then

            custom_section = create_custom_section("Sessions")

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

                table.insert(custom_section.val, button)
            end


            table.insert(custom_dash.config.layout, 5, custom_section)
        end

        -- need to figure out how to call this when "Recent Files" is empty and replace it
        if false then
            custom_section = create_custom_section("Files")

            -- list files in cwd
            local function getCWDFiles()
                -- local cwd = vim.fn.getcwd()
                local files = vim.cmd('!ls<CR>')
                local sep = "\n"
                local file_table = {}
                for str in string.gmatch(files, sep) do
                    table.insert(file_table, str)
                end

                return file_table
            end

            local file_list = getCWDFiles()

            for index, value in ipairs(file_list) do
                local button_map = "<leader>" .. tostring(index-1)
                local button_text = "  " .. value
                local cmd_string = "<cmd>e " .. vim.fn.fnameescape(value) .. "<CR>"

                local button = dashboard.button(button_map, button_text, cmd_string)

                table.insert(custom_section.val, button)
            end


            table.insert(custom_dash.config.layout, 5, file_list)
        end

        alpha.setup(custom_dash.config)
    end
  }
