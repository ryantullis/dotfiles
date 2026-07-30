return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
					"svelte",
					"prismals",
					"html",
				},
				automatic_enable = true,
			})

			vim.lsp.config("lua_ls", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("pyright", {})
			vim.lsp.config("svelte", {
				settings = {
					svelte = {
						plugin = {
							svelte = {
								defaultScriptLanguage = "ts",
							}
						},
						format = {
							config = {
								singleQuote = true
							}
						}
					}
				}
			})
			vim.lsp.config("prismals", {})
			vim.lsp.config("html", {})

			vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, {
				desc = "Open Diagnostic Float",
			})

			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "single" })
			end, {
				desc = "Hover documentation",
			})
		end,
	},
}
