return {
  "numToStr/Comment.nvim",
  dependencies = {
    "LudoPinelli/comment-box.nvim",
    "folke/which-key.nvim",
  },
  opts = {
    -- add any options here
  },
  config = function()
    require("Comment").setup()
    local wk = require("which-key")
    wk.register({
      ["<Leader>cb"] = { "<Cmd>CBccbox<CR>", "Box Title" },
      ["<Leader>ct"] = { "<Cmd>CBllline<CR>", "Titled Line" },
      ["<Leader>cl"] = { "<Cmd>CBline<CR>", "Simple Line" },
      ["<Leader>cm"] = { "<Cmd>CBllbox14<CR>", "Marked" },
      ["<Leader>cd"] = { "<Cmd>CBd<CR>", "Remove a box" },
      ["<Leader>c"] = { name = " □ Boxes" }, -- group name must come **after** child keys
    }, { mode = { "n", "v" } })
  end,
}
