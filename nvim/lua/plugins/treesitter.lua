return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "python", "lua", "json", "yaml", "toml", "vim", "vimdoc" },
            })
        end,
    },
}
