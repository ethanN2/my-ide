return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    priority = 1,
    dependencies = {
        --- Uncomment the two plugins below if you want to manage the language servers from neovim
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "davidsierradz/cmp-conventionalcommits",
            }
        },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "j-hui/fidget.nvim",
        
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim",
                "numToStr/Comment.nvim",
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        local cmp = require("cmp")
        local cmp_action = lsp_zero.cmp_action()
        local luasnip = require("luasnip")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )
        local lspconfig = require("lspconfig")

        -- here you can setup the language servers
        lsp_zero.preset("recommend")

        require("neodev").setup({
          -- add any options here, or leave empty to use the default settings
        })
        require("fidget").setup {}
        require("mason").setup({})
        require("mason-lspconfig").setup({
            -- Replace the language servers listed here
            -- with the ones you want to install
            ensure_installed = { "lua_ls", "clangd" },
            handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    lspconfig[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = {
                                        "vim",
                                        "LazyVim",
                                    },
                                },
                                completion = {
                                    callSnippet = "Replace"
                                }
                            },
                        }
                    }
                end,
                ["clangd"] = function()
                    lspconfig.clangd.setup {
                        on_attach = function(client, bufnr)
                            local navbuddy = require("nvim-navbuddy")
                            navbuddy.attach(client, bufnr)
                        end
                    }
                end
            }
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    --vim.fn["vsnip#anonymous"](args.body)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },

                -- here is where the change happens
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                        nvim_lua = 'Π',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = "conventionalcommits" }
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.keymap.set({"i"}, "<c-k>", function() luasnip.expand() end, {silent = true})
        vim.keymap.set("i", "<c-y>", function()
            cmp.mapping.confirm({ select = true })
        end, { desc = "confirm autocompletion (luasnip)" })
        vim.keymap.set("i", "<c-space>", function()
            cmp.mapping.complete()
        end, { desc = "complete (luasnip)" })
        vim.keymap.set("i", "<Tab>", function()
            cmp_action.luasnip_supertab()
        end, { desc = "super tab (luasnip)" })
        vim.keymap.set("i", "<s-Tab>", function()
            cmp_action.luasnip_shift_supertab()
        end, { desc = "shift super tab (luasnip)" })
        vim.keymap.set("i", "<c-p>", function()
            cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = 'insert' })
                else
                    cmp.complete()
                end
            end)
        end, { desc = "select prev item (luasnip)" })
        vim.keymap.set("i", "<c-p>", function()
            cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = 'insert' })
                else
                    cmp.complete()
                end
            end)
        end, { desc = "select next item (luasnip)" })

        lsp_zero.set_sign_icons({
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "»"
        })

        lsp_zero.format_on_save({
            format_opts = {
                async = nil,
                timeout_ms = nil,
            }
        })

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            local opts = { buffer = bufnr, remap = false }
            lsp_zero.default_keymaps({ buffer = bufnr })

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = bufnr, remap = false, desc = "jump definition (lsp)" })
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { buffer = bufnr, remap = false, desc = "work space (lsp)" })
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = bufnr, remap = false, desc = "open diagnostic (lsp)" })
            vim.keymap.set({ "n", "x" }, "<leader>vf", function() vim.lsp.buf.format() end, { buffer = bufnr, remap = false, desc = "format code (lsp)" })
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, { buffer = bufnr, remap = false, desc = "code action (lsp)" })
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, { buffer = bufnr, remap = false, desc = "references (lsp)" })
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { buffer = bufnr, remap = false, desc = "rename (lsp)" })
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = bufnr, remap = false, desc = "signature help (lsp)" })
            vim.diagnostic.open_float()
        end)

        lsp_zero.setup()

        vim.diagnostic.config({
            virtual_text = {
                spacing = 4,
                source = "if_many",
            },
            document_highlight = {
                enabled = true,
            },
        })
    end
}
