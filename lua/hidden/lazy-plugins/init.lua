return {
    -- toggle terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    },

    -- gramma checker
    {
        "Shougo/denite.nvim",
        "nvim-tree/nvim-tree.lua",
        "rhysd/vim-grammarous"
    },
    -- TODO: do some thing
}

