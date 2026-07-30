return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function ()
		require("nvim-treesitter").setup({})
		require('nvim-treesitter').install{
			"svelte",
			"html",
			"css",
			"javascript",
			"typescript",
			"dockerfile",
			"markdown",
		}
	  vim.api.nvim_create_autocmd('FileType', {
		pattern = {
			"svelte",
			"html",
			"css",
			"javascript",
			"typescript",
			"dockerfile",
			"markdown",
		},
		callback = function()
		  -- syntax highlighting, provided by Neovim
		  vim.treesitter.start()
		  -- folds, provided by Neovim
		  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		  vim.wo.foldmethod = 'expr'
		  -- indentation, provided by nvim-treesitter
		  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	  })
		end
	}
}
