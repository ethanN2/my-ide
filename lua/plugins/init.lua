return {
	{
		"LazyVim/LazyVim",
		opts = {
			defaults = {
				autocmds = true, -- lazyvim.config.autocmds
				keymaps = false, -- lazyvim.config.keymaps
				options = true, -- lazyvim.config.options
			},
			news = {
				lazyvim = true,
				neovim = true,
			},
		},
	},
	-- toggle terminal
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end,
	},
}
