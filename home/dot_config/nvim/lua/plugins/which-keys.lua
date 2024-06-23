local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		vim.keymap.set("n", "<Leader>h", ":WhichKey<CR>", { silent = true }),
	},
}
return M
