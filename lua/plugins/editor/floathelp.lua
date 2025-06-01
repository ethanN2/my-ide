return {
    "Tyler-Barham/floating-help.nvim",
    config = function()
        local fh = require('floating-help')

        fh.setup({
            -- Defaults
            width = 80,                        -- Whole numbers are columns/rows
            height = 0.9,                      -- Decimals are a percentage of the editor
            position = 'SE',                   -- NW,N,NW,W,C,E,SW,S,SE (C==center)
            border = 'rounded',                -- rounded,double,single
            onload = function(query_type) end, -- optional callback to be executed after help contents has been loaded
        })

        -- Create a keymap for toggling the help window
        vim.keymap.set('n', '<leader>h', function() fh.toggle() end, { desc = "toggle floating-help" })
        -- Create a keymap to search cppman for the word under the cursor
        vim.keymap.set('n', '<leader>hk', function() fh.open('t=cppman', vim.fn.expand('<cword>')) end,
            { desc = "search word under cursor floating-help" })
        -- Create a keymap to search man for the word under the cursor
        vim.keymap.set('n', '<leader>hm', function() fh.open('t=man', vim.fn.expand('<cword>')) end,
            { desc = "search man for the word under cursor floating-help" })

        -- Only replace cmds, not search; only replace the first instance
        local function cmd_abbrev(abbrev, expansion)
            local cmd = 'cabbr ' ..
                abbrev ..
                ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "' .. expansion .. '" : "' .. abbrev .. '")<CR>'
            vim.cmd(cmd)
        end

        -- Redirect `:h` to `:FloatingHelp`
        cmd_abbrev('h', 'FloatingHelp')
        cmd_abbrev('help', 'FloatingHelp')
        cmd_abbrev('helpc', 'FloatingHelpClose')
        cmd_abbrev('helpclose', 'FloatingHelpClose')
    end
}
