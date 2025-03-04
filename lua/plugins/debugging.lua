
return {

  { -- Trouble: A pretty list for showing diagnostics, references, telescope results,
    -- quickfix and location lists to help you solve all the trouble your code is causing.
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },

  { -- nvim dap: 
    "mfussenegger/nvim-dap",
  },

  { -- nvim-dap-ui:
    "rcarriga/nvim-dap-ui",

    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup()

      local dap = require('dap')

      dap.listeners.before.attach.dapui_config = function ()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function ()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function ()
        dapui.open()
      end

      dap.listeners.before.event_exited.dapui_config = function ()
        dapui.open()
      end

    end
  },

}
