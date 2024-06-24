return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }
        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }

        -- this is my config
        vim.opt.list = true
        --vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↵"
        vim.opt.listchars:append "tab:|⇢"
        vim.opt.listchars:append "trail:·"
        vim.opt.listchars:append "extends:>"
        vim.opt.listchars:append "precedes:<"

        require("ibl").setup {
            whitespace = {
                remove_blankline_trail = true,
            },
            indent = {
                char = "▎",
                tab_char = "▎",
            },
            scope = {
                highlight = highlight,
                char = "▎",
                priority = 1024,
                include = {
                    node_type = {
                        ["*"] = {
                            "^argument",
                            "^expression",
                            "^for",
                            "^if",
                            "^import",
                            "^type",
                            "arguments",
                            "block",
                            "bracket",
                            "declaration",
                            "field",
                            "func_literal",
                            "function",
                            "import_spec_list",
                            "list",
                            "return_statement",
                            "short_var_declaration",
                            "statement",
                            "switch_body",
                            "try",
                            "block_mapping_pair",
                        },
                    },
                },
            },
            exclude = {
                filetypes = {
                    "help",
                    "startify",
                    "dashboard",
                    "packer",
                    "neogitstatus",
                    "NvimTree",
                    "Trouble",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                buftypes = {
                    "terminal",
                    "nofile",
                },
            }
        }

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
}
