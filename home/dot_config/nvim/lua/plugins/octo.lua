local M = {
	"pwntester/octo.nvim",
	event = "VeryLazy",
	lazy = not vim.g.started_by_firenvim,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("octo").setup()
	end,
}
return M
