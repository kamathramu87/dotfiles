return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File explorer" },
        },
        config = function()
            require("nvim-tree").setup({
                filters = { dotfiles = false },
                view = { width = 30 },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
            { "gcc", desc = "Comment toggle line" },
        },
        config = function()
            require("Comment").setup()
        end,
    },
}
