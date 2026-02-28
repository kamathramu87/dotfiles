return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                config = function()
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup()
                    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
                    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
                    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
                end,
            },
            {
                "mfussenegger/nvim-dap-python",
                config = function()
                    require("dap-python").setup("python3")
                end,
            },
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        },
    },
}
