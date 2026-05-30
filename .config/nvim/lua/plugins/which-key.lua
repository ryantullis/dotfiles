return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
	preset = "modern",
	spec = {
    	      { "<leader>f", group = "+find" },
	}
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
