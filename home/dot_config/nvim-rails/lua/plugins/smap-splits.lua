local M = {
	"mrjones2014/smart-splits.nvim",
	event = "VeryLazy",
}
function M.config()
	require("smart-splits").setup({
		ignored_buftypes = {
			"nofile",
			"quickfix",
			"prompt",
			"fern",
		},
		-- Ignored filetypes (only while resizing)
		ignored_filetypes = { "NvimTree", "Fern" },
		default_amount = 8,
	})
	vim.keymap.set("n", "<C-M-H>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<C-M-J>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<C-M-K>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<C-M-L>", require("smart-splits").resize_right)
	vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
	vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
	vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
	vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
end

return M
