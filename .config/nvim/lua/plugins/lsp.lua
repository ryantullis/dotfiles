return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"lua_ls",
				"pyright",
			}
		}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			vim.lsp.config('lua_ls', {})
			vim.lsp.config('ts_ls', {})
			vim.lsp.config('pyright', {})

			vim.lsp.enable('lua_ls')
			vim.lsp.enable('ts_ls')
			vim.lsp.enable('pyright')

			vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
		end,
	}
}
