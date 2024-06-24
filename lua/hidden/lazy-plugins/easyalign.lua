return {
    "junegunn/vim-easy-align",
    config = function ()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {desc = "start interactive in v mode (EasyAlign)"})
        vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {desc = "start interactive in n mode (EasyAlign)"})
    end
}
