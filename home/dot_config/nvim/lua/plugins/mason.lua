local M = {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				height = 0.8,
			},
		})
	end,
}
return M
