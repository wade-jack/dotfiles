return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- required for problem rendering
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lang = "python3", -- or "cpp", "java", "javascript", etc.
        },
    },
}
