return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { 
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local function finder()
                local paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(paths, item.value)
                end

                return require("telescope.finders").new_table({
                    results = paths,
                })
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = finder(),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    map("i", "<C-d>", function()
                        local state = require("telescope.actions.state")
                        local selected_entry = state.get_selected_entry()
                        local current_picker = state.get_current_picker(prompt_bufnr)

                        table.remove(harpoon_files.items, selected_entry.index)
                        current_picker:refresh(finder())
                    end)
                    return true
                end,
            }):find()
        end

        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "add entry to harpoon" })
        --vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) -- default setup
        vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "open harpoon window with telescope" })
        -- vim.keymap.set("n", "<C-d>", function() harpoon:list end, { desc = "open harpoon window with telescope" })

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "quick select 1" })
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "quick select 2" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "quick select 3" })
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "quick select 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "toggle previous buffer" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "toggle next buffer" })
    end
}
