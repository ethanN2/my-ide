vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yank into system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "yank motion" }) -- yank motion
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y', { desc = "yank line" }) -- yank line
