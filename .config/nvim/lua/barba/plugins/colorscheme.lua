return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
        require('kanagawa').setup({
            theme = "wave", -- or "dragon", "lotus"
            transparent = false,
            -- other defaults
        })

        vim.cmd("colorscheme kanagawa")
    end,
}
