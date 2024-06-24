return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    branch = "v3.x",
    cmd = "Neotree",
    --keys = {
    --    {
    --        "<leader>fe",
    --        function()
    --            require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
    --        end,
    --        desc = "Explorer NeoTree (Root Dir)",
    --    },
    --    {
    --        "<leader>fE",
    --        function()
    --            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
    --        end,
    --        desc = "Explorer NeoTree (cwd)",
    --    },
    --    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    --    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
    --    {
    --        "<leader>ge",
    --        function()
    --            require("neo-tree.command").execute({ source = "git_status", toggle = true })
    --        end,
    --        desc = "Git Explorer",
    --    },
    --    {
    --        "<leader>be",
    --        function()
    --            require("neo-tree.command").execute({ source = "buffers", toggle = true })
    --        end,
    --        desc = "Buffer Explorer",
    --    },
    --},
    init = function()
        vim.api.nvim_create_augroup("neotree", {})
        vim.api.nvim_create_autocmd("UiEnter", {
            desc = "Open Neotree automatically",
            group = "neotree",
            callback = function()
                if vim.fn.argc() == 0 then
                    vim.cmd "Neotree show"
                end
            end,
        })
    end,
    config = function()
        vim.fn.sign_define("DiagnosticSignError",
            { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn",
            { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo",
            { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint",
            { text = "󰌵", texthl = "DiagnosticSignHint" })
        local neotree = require("neo-tree")
        neotree.setup({
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added    = "󱇬", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "󰦒", --
                    },
                },
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,          -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
            },
            hijack_netrw_behavior = "open_current",
            buffers = {
                follow_current_file = {
                    enabled = true,  -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
            }
        })
    end,
}
