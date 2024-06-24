return {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }

        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.tempt = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git", -- local path or git repo
                files = { "src/parser.c", "src/scanner" },                   -- note that some parsers also require src/scanner.c or src/scanner.cc
                branch = "master",                                           -- default branch in case of git repo if different from master
            },
        }

        vim.treesitter.language.register('templ', 'templ')
    end
}
