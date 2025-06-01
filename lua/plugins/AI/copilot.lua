return {
	"CopilotC-Nvim/CopilotChat.nvim",
	"github/copilot.vim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = function()
		local user = vim.env.USER or "User"
		user = user:sub(1, 1):upper() .. user:sub(2)
		return {
			auto_insert_mode = true,
			question_header = "  " .. user .. " ",
			answer_header = "  Copilot ",
			window = {
				width = 0.4,
			},
		}
	end,
	keys = {
		{ "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
		{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
		{
			"<leader>aa",
			function()
				return require("CopilotChat").toggle()
			end,
			desc = "Toggle (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ax",
			function()
				return require("CopilotChat").reset()
			end,
			desc = "Clear (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>aq",
			function()
				vim.ui.input({
					prompt = "Quick Chat: ",
				}, function(input)
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end)
			end,
			desc = "Quick Chat (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>ap",
			function()
				require("CopilotChat").select_prompt()
			end,
			desc = "Prompt Actions (CopilotChat)",
			mode = { "n", "v" },
		},
	},
	config = function(_, opts)
		local chat = require("CopilotChat")

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		chat.setup(opts)
		-- Optional: disable copilot for certain filetypes
		vim.g.copilot_filetypes = {
			markdown = false,
			gitcommit = false,
		}

		-- Optional: suggestion toggle (e.g. <M-\>)
		vim.cmd([[
      imap <silent><script><expr> <M-\> copilot#Accept("\<CR>")
    ]])
	end,
}
