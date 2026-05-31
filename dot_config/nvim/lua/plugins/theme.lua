return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- load before other plugins
        opts = {
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
        },
    },

    -- Tell LazyVim to use catppuccin
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
