return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "Format file",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_format", "black" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = true,
                },
            })

            -- Run organize imports + fix all before formatting on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("RuffFixOnSave", { clear = true }),
                pattern = "*.py",
                callback = function()
                    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports.ruff" } }, apply = true })
                    vim.lsp.buf.code_action({ context = { only = { "source.fixAll.ruff" } }, apply = true })
                end,
            })
        end,
    },
}
