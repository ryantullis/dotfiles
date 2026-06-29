require("config.lazy")
vim.o.background='dark'
vim.cmd([[colorscheme gruvbox]])
vim.keymap.set("n","<leader>e", vim.cmd.Ex, { desc = "Explorer" })
-- transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.number=true
