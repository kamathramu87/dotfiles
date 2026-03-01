return {
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
        ft = "python",
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<CR>", desc = "Select venv" },
        },
        opts = {},
    },
}
