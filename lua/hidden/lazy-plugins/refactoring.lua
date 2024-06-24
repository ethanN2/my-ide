return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end, { desc = "refactor extract to file in visual mode" })
        vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, { desc = "refactor extract var in visual mode" })
        -- Extract function supports only visual mode
        vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, { desc = "refactor extract var in visual mode" })
        -- Extract variable supports only visual mode
        vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end, { desc = "refactor extract inline var" })
        -- Inline func supports only normal
        vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, { desc = "refactor extract inline var in visual or normal mode" })
        -- Inline var supports both normal and visual mode

        vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end, { desc = "refactor extract block" })
        vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end, { desc = "refactor extract block to file" })
        -- Extract block supports only normal mode    vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "refactor extract" })
        require("refactoring").setup()
    end,
}
