local M = {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	config = {
		auto_open = false,
		use_diagnostic_signs = true,
	},
}

function M.config()
	local status, trouble = pcall(require, "trouble")
	if not status then
		return
	end
	-- Trouble
	trouble.setup({})
	vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap(
		"n",
		"<leader>xw",
		"<cmd>Trouble workspace_diagnostics<cr>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>xd",
		"<cmd>Trouble document_diagnostics<cr>",
		{ silent = true, noremap = true }
	)
	vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
	vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
end

return M
