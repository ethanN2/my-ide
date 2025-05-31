vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yank into system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = "yank motion" }) -- yank motion
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y', { desc = "yank line" })   -- yank line

-- setup build cpp
vim.api.nvim_create_user_command("CppBuild", function()
    local cwd = vim.fn.getcwd()
    local cmd = "FloatermNew --autoclose=0 " ..
        "cd " .. cwd .. " &&" ..
        "cmake -S all -B build -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build " ..
        "./build/test/GreeterTests"
    vim.cmd("echo " .. cmd)
    vim.cmd(cmd)
end, { desc = "Build and test C++ project" })
