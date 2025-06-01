return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {
        prompt_func_return_type = {
            cpp = true,
        },
        prompt_func_param_type = {
            cpp = true,
        },
        show_success_message = true,
    },
    config = function()
        vim.g.refactoring_debug = true
        require("refactoring").setup()
        vim.keymap.set({ "n", "x" }, "<leader>re", function() return require('refactoring').refactor('Extract Function') end,
            { desc = "refactor extract to file in visual mode" }, { expr = true })
        vim.keymap.set({ "n", "x" }, "<leader>rf",
            function() return require('refactoring').refactor('Extract Function To File') end,
            { desc = "refactor extract var in visual mode" }, { expr = true })
        -- Extract function supports only visual mode
        vim.keymap.set({ "n", "x" }, "<leader>rv", function() return require('refactoring').refactor('Extract Variable') end,
            { desc = "refactor extract var in visual mode" }, { expr = true })
        -- Extract variable supports only visual mode
        vim.keymap.set({ "n", "x" }, "<leader>rI", function() return require('refactoring').refactor('Inline Function') end,
            { desc = "refactor extract inline var" }, { expr = true })
        -- Inline func supports only normal
        vim.keymap.set({ "n", "x" }, "<leader>ri", function() return require('refactoring').refactor('Inline Variable') end,
            { desc = "refactor extract inline var in visual or normal mode" }, { expr = true })
        -- Inline var supports both normal and visual mode

        vim.keymap.set({ "n", "x" }, "<leader>rb", function() return require('refactoring').refactor('Extract Block') end,
            { desc = "refactor extract block" }, { expr = true })
        vim.keymap.set({ "n", "x" }, "<leader>rbf",
            function() return require('refactoring').refactor('Extract Block To File') end,
            { desc = "refactor extract block to file" }, { expr = true })
        -- Extract block supports only normal mode    vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "refactor extract" })
    end,
}
