return {
    "mbbill/undotree",
    config = function ()
        -- when open undotree hide neotree
        vim.keymap.set("n", "<leader>u", function()
            local manager = require("neo-tree.sources.manager")
            local renderer = require("neo-tree.ui.renderer")
            local state = manager.get_state("filesystem")
            local window_exists = renderer.window_exists(state)
            if window_exists then
                vim.cmd.UndotreeShow()
                vim.cmd "Neotree close"
            else
                vim.cmd.UndotreeHide()
                vim.cmd "Neotree show"
            end
        end, { desc = "toggle undotree" })
    end
}
