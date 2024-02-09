return {
	"fraso-dev/nvim-listchars",
	event = "VeryLazy",
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
		})
		vim.cmd([[ListcharsEnable]])
	end,
}
