return {
    "tpope/vim-fugitive",
    dependencies = {
    "lewis6991/gitsigns.nvim",
},
    config = function ()
        local gitsigns = require("gitsigns")
        gitsigns.setup({})
        -- Navigation
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, { desc = "see diff" })

        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, { desc = "see diff" })

        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = "stage hunk" })
        vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = "reset hunk" })
        vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "stage hunk in v mode" })
        vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "reset hunk in v mode" })
        vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = "stage buffer" })
        vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "undo stage hunk" })
        vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = "reset buffer" })
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = "preview hunk" })
        vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "blame line" })
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "toggle current line blame" })
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = "diff" })
        vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "diff" })
        vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted, { desc = "toggle deleted " })

        -- Text object
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "select hunk" })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "open fuditive git" })
    end
}
