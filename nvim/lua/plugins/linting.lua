return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                python = { "ruff" },
            }
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("UserLinting", { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
