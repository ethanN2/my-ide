return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{ "mfussenegger/nvim-dap" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "williamboman/mason.nvim" },
		{ "nvim-neotest/nvim-nio" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup()
		dapui.setup()
		-- require("neodev").setup({
		--   library = { plugins = { "nvim-dap-ui" }, types = true },
		-- })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
			vim.cmd("Neotree close")
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
			vim.cmd("Neotree close")
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
			vim.cmd("Neotree show")
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
			vim.cmd("Neotree show")
		end

		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)

		vim.keymap.set("n", "<F5>", function()
			require("dap").continue()
		end, { desc = "continue (dap)" })
		vim.keymap.set("n", "<F10>", function()
			require("dap").step_over()
		end, { desc = "step over (dap)" })
		vim.keymap.set("n", "<F11>", function()
			require("dap").step_into()
		end, { desc = "step info (dap)" })
		vim.keymap.set("n", "<F12>", function()
			require("dap").step_out()
		end, { desc = "step out (dap)" })
		vim.keymap.set("n", "<Leader>b", function()
			require("dap").toggle_breakpoint()
		end, { desc = "toggle breakpoint (dap)" })
		vim.keymap.set("n", "<Leader>B", function()
			require("dap").set_breakpoint(vim.fn.input("Point condition: "), nil, vim.fn.input("message log:"))
		end, { desc = "set breakpoint (dap) ex: set_breakpoint('i == 5')" })
		vim.keymap.set("n", "<Leader>lp", function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "set breakpoint with message (dap)" })
		vim.keymap.set("n", "<Leader>dr", function()
			require("dap").repl.open()
		end, { desc = "open (dap)" })
		vim.keymap.set("n", "<Leader>dl", function()
			require("dap").run_last()
		end, { desc = "run last (dap)" })
		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "hover (dap)" })
		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			require("dap.ui.widgets").preview()
		end, { desc = "preview (dap)" })
		vim.keymap.set("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, { desc = "center float window frame (dap)" })
		vim.keymap.set("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, { desc = "center float window scope (dap)" })
		vim.keymap.set("n", "<Leader>dc", function()
			dapui.close()
		end, { desc = "close debug (dap)" })

		dap.set_log_level("TRACE")

		-- setup cpp project
		if not dap.adapters["codelldb"] then
			dap.adapters["codelldb"] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = {
						"port",
						"${port}",
					},
				},
			}
		end

		dap.configurations.c = {
			{
				name = "corelldb debugging",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				program = "${fileDirname}/${fileBasenameNoExtension}",
				cwd = "${workspaceFolder}",
				terminal = "integrated",
			},
		}

		for _, lang in ipairs({ "c", "cpp" }) do
			dap.configurations[lang] = {
				{
					type = "codelldb",
					request = "launch",
					name = "Launch file",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					type = "codelldb",
					request = "attach",
					name = "Attach to process",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
