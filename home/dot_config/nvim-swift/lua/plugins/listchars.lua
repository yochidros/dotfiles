return {
	"fraso-dev/nvim-listchars",
	-- event = "VeryLazy",
	priority = 100,
	config = function()
		require("nvim-listchars").setup({
			save_state = false,
			listchars = {
				space = "⋅",
				trail = "-",
				eol = "↲",
				tab = "» ",
			},
			exclude_filetypes = {
				"alpha",
			},
			lighten_step = 10,
			notifications = false,
		})
		vim.cmd([[ListcharsEnable]])
	end,
}
