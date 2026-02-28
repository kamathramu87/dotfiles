return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Use the new vim.lsp.config API (nvim 0.11+)
            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },
            })
            vim.lsp.enable("pyright")

            vim.lsp.config("ruff", {
                capabilities = capabilities,
            })
            vim.lsp.enable("ruff")

            -- LSP keymaps on attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>co", function()
                        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports.ruff" } }, apply = true })
                    end, { buffer = ev.buf, desc = "Organize imports" })
                    vim.keymap.set("n", "<leader>cu", function()
                        vim.lsp.buf.code_action({ context = { only = { "source.fixAll.ruff" } }, apply = true })
                    end, { buffer = ev.buf, desc = "Fix all (ruff)" })
                end,
            })
        end,
    },
}
