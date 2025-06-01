return {
    "nvim-neotest/neotest",
    dependencies = {
        "alfaix/neotest-gtest",
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    opts = {
        -- Can be a list of adapters like what neotest expects,
        -- or a list of adapter names,
        -- or a table of adapter names, mapped to adapter configs.
        -- The adapter will then be automatically loaded with the config.
        adapters = {},
        -- Example for loading neotest-go with a custom config
        -- adapters = {
        --   ["neotest-go"] = {
        --     args = { "-tags=integration" },
        --   },
        -- },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
            open = function()
                if LazyVim.has("trouble.nvim") then
                    require("trouble").open({ mode = "quickfix", focus = false })
                else
                    vim.cmd("copen")
                end
            end,
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-gtest").setup({})
            },
        })
    end
}
