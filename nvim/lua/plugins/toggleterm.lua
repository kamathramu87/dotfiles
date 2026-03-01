return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<leader>tt", desc = "Toggle terminal" },
        },
        opts = {
            open_mapping = false,
            direction = "float",
            float_opts = {
                border = "curved",
            },
            shade_terminals = true,
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            local Terminal = require("toggleterm.terminal").Terminal
            local float_term = Terminal:new({ direction = "float" })

            vim.keymap.set({ "n", "t" }, "<leader>tt", function()
                float_term:toggle()
            end, { desc = "Toggle terminal" })
        end,
    },
}
