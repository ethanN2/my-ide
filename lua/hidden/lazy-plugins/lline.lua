return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    config = function()
        -- Bubbles config for lualine
        -- Author: lokesh-krishna
        -- MIT license, see LICENSE for more details.

        -- stylua: ignore
        local colors = {
            green     = "#c3e88d",
            blue      = '#80a0ff',
            cyan      = '#79dac8',
            black     = '#080808',
            white     = '#c6c6c6',
            red       = '#ff5189',
            violet    = '#d183e8',
            grey      = '#303030',
            yellow    = "#ffc777",
            blue_info = '#89ddff',
        }

        local bubbles_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.violet, gui = 'bold' },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white, bg = colors.black },
                x = { fg = colors.white, bg = colors.black },
            },

            insert = { a = { fg = colors.black, bg = colors.blue } },
            visual = { a = { fg = colors.black, bg = colors.cyan } },
            replace = { a = { fg = colors.black, bg = colors.red } },

            inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
            },
        }

        require('lualine').setup({
            options = {
                theme = bubbles_theme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = {
                    {
                        'branch',
                    },
                    {
                        'diff',
                        colored = true, -- Displays a colored diff status if set to true
                        diff_color = {
                            -- Same color values as the general color option can be used here.
                            added    = { fg = colors.green },                     -- Changes the diff's added color
                            modified = { fg = colors.yelnnlow },                  -- Changes the diff's modified color
                            removed  = { fg = colors.rednn },                     -- Changes the diff's removed color you
                        },
                        symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
                        source = nil,                                             -- A function that works as a data source for diff.
                        -- It must return a table as such:
                        --   { added = add_count, modified = modified_count, removed = removed_count }
                        -- or nil on failure. count <= 0 won't be displayed.
                    },
                    {
                        'diagnostics',
                        -- Table of diagnostic sources, available sources are:
                        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                        -- or a function that returns a table as such:
                        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                        sources = { 'nvim_lsp' },

                        -- Displays diagnostics for the defined severity types
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = { fg = colors.red },       -- Changes diagnostics' error color.
                            warn  = { fg = colors.yellow },    -- Changes diagnostics' warn color.
                            info  = { fg = colors.blue_info }, -- Changes diagnostics' info color.
                            hint  = { fg = colors.grey },      -- Changes diagnostics' hint color.
                        },
                        symbols = {
                            error = 'E',
                            warn = 'W',
                            info = 'I',
                            hint = 'H'
                        },
                        colored = true,           -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false,   -- Show diagnostics even if there are none.
                    }
                },
                lualine_c = {
                    {
                        '%=', --[[ add your center compoentnts here in place of this comment ]]
                        separator = { left = "", right = "" },
                    },
                    {
                        'filename',
                        file_status = true,     -- Displays file status (readonly status, modified status)
                        separator = { left = "", right = "" },
                        newfile_status = false, -- Display new file status (new file means no write after created)
                        path = 1,               -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory

                        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = '[+]',      -- Text to show when the file is modified.
                            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]',     -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_x = {
                    {
                        'encoding',
                    },
                    {
                        'fileformat',
                    },
                    {
                        'filetype',
                        colored = true,    -- Displays filetype icon in color if set to true
                        icon_only = false, -- Display only an icon for filetype
                    },
                },
                lualine_y = { 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        })
    end
}
