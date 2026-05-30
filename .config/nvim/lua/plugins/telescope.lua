return {
	{
	    'nvim-telescope/telescope.nvim', version = '*',
	    dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	    },
	    config = function()
		vim.keymap.set("n","<leader>ff",require("telescope.builtin").find_files, { desc = "Find Files" })
		vim.keymap.set("n","<leader>fb",require("telescope.builtin").buffers, { desc = "Buffers" })
	    end
	}
}
