return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	priority = 1,
	dependencies = {
		-- Uncomment the two plugins below if you want to manage the language servers from neovim
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"hrsh7th/cmp-nvim-lsp",
		"j-hui/fidget.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		{
			"folke/neodev.nvim",
			lazy = false,
			config = true,
		},
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
				"numToStr/Comment.nvim",
			},
			opts = { lsp = { auto_attach = true } },
		},
	},
	config = function()
		local lsp_zero = require("lsp-zero")
		local lspconfig = require("lspconfig")

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)
		-- here you can setup the language servers

		require("neodev").setup({
			-- add any options here, or leave empty to use the default settings
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})
		require("fidget").setup({})
		require("mason").setup({})
		require("mason-lspconfig").setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = { "lua_ls", "clangd", "omnisharp" },
			handlers = {
				lsp_zero.default_setup,
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				["lua_ls"] = function()
					local capabilities = vim.tbl_deep_extend(
						"force",
						{},
						vim.lsp.protocol.make_client_capabilities(),
						require("cmp_nvim_lsp").default_capabilities()
					)
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = vim.split(package.path, ";"),
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = {
										"use",
										"vim",
										"require",
										"LazyVim",
									},
								},
								telemetry = { enable = false },
								completion = {
									callSnippet = "Replace",
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
							},
						},
					})
				end,
				["clangd"] = function()
					local capabilities = vim.tbl_deep_extend(
						"force",
						vim.lsp.protocol.make_client_capabilities(),
						require("cmp_nvim_lsp").default_capabilities()
					)
					lspconfig.clangd.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							local navbuddy = require("nvim-navbuddy")
							navbuddy.attach(client, bufnr)
							-- if you want add more header just define file <your-header>.h in to
							--  ~/.local/share/nvim/mason/packages/clangd/clangd_18.1.3/lib/clang/18/include folder
							--  it will be ok
						end,
						cmd = { "clangd", "--compile-commands-dir=build" },
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
						root_dir = lspconfig.util.root_pattern(
							".clangd",
							".clang-tidy",
							".clang-format",
							"compile_commands.json",
							"compile_flags.txt",
							"configure.ac",
							".git"
						),
						single_file_support = true,
					})
				end,
				["omnisharp"] = function()
					local capabilities =
						require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
					local pid = vim.fn.getpid()
					local omnisharp_bin = "/Users/hidden/omnisharp-osx-arm64-net6.0/OmniSharp.dll"

					local on_attach = function(client, bufnr)
						vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
						-- Mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						vim.keymap.set(
							"n",
							"gD",
							"<cmd>lua vim.lsp.buf.declaration()<CR>",
							{ buffer = bufnr, remap = false, desc = "jump omnisharp delclaration (lsp)" }
						)
						vim.keymap.set(
							"n",
							"gd",
							"<cmd>lua vim.lsp.buf.definition()<CR>",
							{ buffer = bufnr, remap = false, desc = "jump omnisharp definition (lsp)" }
						)
						vim.keymap.set(
							"n",
							"K",
							"<cmd>lua vim.lsp.buf.hover()<CR>",
							{ buffer = bufnr, remap = false, desc = "hover omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"gi",
							"<cmd>lua vim.lsp.buf.implementation()<CR>",
							{ buffer = bufnr, remap = false, desc = "implementation omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<C-h>",
							"<cmd>lua vim.lsp.buf.signature_help()<CR>",
							{ buffer = bufnr, remap = false, desc = "signature help omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>wa",
							"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
							{ buffer = bufnr, remap = false, desc = "add workspace folder omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>wr",
							"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
							{ buffer = bufnr, remap = false, desc = "remove workspace folder omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>wl",
							"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
							{ buffer = bufnr, remap = false, desc = "remove workspace folder omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>D",
							"<cmd>lua vim.lsp.buf.type_definition()<CR>",
							{ buffer = bufnr, remap = false, desc = "type definition omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>vrn",
							"<cmd>lua vim.lsp.buf.rename()<CR>",
							{ buffer = bufnr, remap = false, desc = "rename omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>vca",
							"<cmd>lua vim.lsp.buf.code_action()<CR>",
							{ buffer = bufnr, remap = false, desc = "code action omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>vrr",
							"<cmd>lua vim.lsp.buf.references()<CR>",
							{ buffer = bufnr, remap = false, desc = "references omnisharp (lsp)" }
						)
						vim.keymap.set(
							"n",
							"<space>vf",
							"<cmd>lua vim.lsp.buf.formatting()<CR>",
							{ buffer = bufnr, remap = false, desc = "formatting omnisharp (lsp)" }
						)
					end

					lspconfig.omnisharp.setup({
						capabilities = capabilities,
						cmd = { "dotnet", omnisharp_bin, "--languageserver", "--postPID", tostring(pid) },
						on_attach = on_attach,
					})
				end,
			},
			servers = {
				neocmake = {},
			},
		})

		lsp_zero.set_sign_icons({
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "»",
		})

		lsp_zero.format_on_save({
			format_opts = {
				async = nil,
				timeout_ms = nil,
			},
		})

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			local opts = { buffer = bufnr, remap = false }
			lsp_zero.default_keymaps({ buffer = bufnr })

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, { buffer = bufnr, remap = false, desc = "jump definition (lsp)" })
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, { buffer = bufnr, remap = false, desc = "work space (lsp)" })
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, { buffer = bufnr, remap = false, desc = "open diagnostic (lsp)" })
			vim.keymap.set({ "n", "x" }, "<leader>vf", function()
				vim.lsp.buf.format()
			end, { buffer = bufnr, remap = false, desc = "format code (lsp)" })
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, { buffer = bufnr, remap = false, desc = "code action (lsp)" })
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, { buffer = bufnr, remap = false, desc = "references (lsp)" })
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, { buffer = bufnr, remap = false, desc = "rename (lsp)" })
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, { buffer = bufnr, remap = false, desc = "signature help (lsp)" })
			vim.diagnostic.open_float()
		end)

		lsp_zero.setup()

		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				source = "if_many",
			},
			document_highlight = {
				enabled = true,
			},
		})
	end,
}
