require("config.lazy")
vim.o.background=dark
vim.cmd([[colorscheme gruvbox]])
vim.keymap.set("n","<leader>e", vim.cmd.Ex, { desc = "Explorer" })
