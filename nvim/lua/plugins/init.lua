-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.ui"),
    require("plugins.treesitter"),
    require("plugins.lsp"),
    require("plugins.cmp"),
    require("plugins.telescope"),
    require("plugins.formatting"),
    require("plugins.linting"),
    require("plugins.dap"),
    require("plugins.extras"),
    require("plugins.toggleterm"),
}, {
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true, notify = false },
})
