return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function ()
			vim.keymap.set("n", "<leader><Tab>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true,          -- Show filtered items
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,     -- Windows hidden files
						never_show = {},         -- Don't force-hide anything
					},
				},
				event_handlers = {
					{
						event = "file_open_requested",
						handler = function()
							require("neo-tree.command").execute({
								action = "close",
							})
						end,
					},
				},
			})
		end,
	}
}
