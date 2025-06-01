return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- Optional custom keymap tweaks
    vim.g.VM_default_mappings = 1
    vim.g.VM_maps = {
      ["Find Under"]         = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Select All"]         = "\\A",
      ["Visual Cursors"]     = "\\<C-n>",
    }
  end,
}
