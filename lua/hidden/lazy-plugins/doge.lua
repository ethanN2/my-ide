return {
    "kkoomen/vim-doge",
    config = function ()
        vim.g.doge_enable_mappings = 0
        vim.g.doge_doc_standard_lua = "ldoc"
        vim.g.doge_doc_standard_cpp = "doxygen_javadoc"
        vim.g.doge_doc_standard_c = "doxygen_javadoc"
        vim.g.doge_doc_standard_cs = "xmldoc"
        vim.g.doge_mapping_comment_jump_forward = "<C-j>"
        vim.g.doge_mapping_comment_jump_backward = "<C-k>"
        vim.g.doge_buffer_mappings = 1
        vim.g.doge_comment_jump_modes = { "n", "i", "s" }
        vim.g.doge_mapping = ""
        -- Generate comment for current line
        vim.keymap.set('n', '<Leader>z', '<Plug>(doge-generate)')
        vim.keymap.set('n', '<Leader>d', "", { desc = nil })

        -- Interactive mode comment todo-jumping
        vim.keymap.set('n', '<TAB>', '<Plug>(doge-comment-jump-forward)')
        vim.keymap.set('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
        vim.keymap.set('i', '<C-j>', '<Plug>(doge-comment-jump-forward)')
        vim.keymap.set('i', '<C-k>', '<Plug>(doge-comment-jump-backward)')
        vim.keymap.set('x', '<TAB>', '<Plug>(doge-comment-jump-forward)')
        vim.keymap.set('x', '<S-TAB>', '<Plug>(doge-comment-jump-backward)')
        vim.cmd(":call doge#install()")
    end
}
