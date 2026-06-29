return {
	{
		'nvim-telescope/telescope.nvim', version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n","<leader>ff",require("telescope.builtin").find_files, { desc = "Find Files" })
			vim.keymap.set("n","<leader>fh",function ()
				builtin.find_files({ hidden = true })
			end, { desc = "Hidden Files" })
			vim.keymap.set("n","<leader>fc",function ()
				builtin.find_files({ hidden = true, cwd = '$HOME/.dotfiles/.config/nvim/'})
			end, { desc = "Config Files" })
			vim.keymap.set("n","<leader>fg",require("telescope.builtin").git_files, { desc = "Git Files" })
			vim.keymap.set("n","<leader>fb",require("telescope.builtin").buffers, { desc = "Buffers" })
		end
	}
}
