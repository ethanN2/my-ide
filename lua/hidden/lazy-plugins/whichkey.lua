return {
    "folke/which-key.nvim",
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        plugins = { spelling = true },
        defaults = {
              mode = { "n", "v" },
              {
                    { "g",  group = "+goto" },
                    { "gs", group = "+surround" },
                    { "z",  group = "+fold" },
                    { "]",  group = "+next" },
                    { "[",  group = "+prev" },
                    { "<leader><tab>", group = "+tabs" },
                    { "<leader>b",     group = "+buffer" },
                    { "<leader>c",     group = "+code" },
                    { "<leader>f",     group = "+file/find" },
                    { "<leader>g",     group = "+git" },
                    { "<leader>gh",    group = "+hunks" },
                    { "<leader>q",     group = "+quit/session" },
                    { "<leader>s",     group = "+search" },
                    { "<leader>u",     group = "+ui" },
                    { "<leader>w",     group = "+windows" },
                    { "<leader>x",     group = "+diagnostics/quickfix" },
              },
        },
    },
    config = function(_, opts)
        require("mini.icons").setup()
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
        vim.keymap.set("n", "<leader>w", function ()
            wk.show()
        end, {desc = "open which-key"})
    end,
}
