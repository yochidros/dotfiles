local M = {
	"glepnir/lspsaga.nvim",
	branch = "main",
	event = "BufReadPre",
}
function M.config()
	local status, lspsaga = pcall(require, "lspsaga")
	if not status then
		return
	end

	lspsaga.setup({
		diagnostic = {
			-- if disable diagnostics in Insert mode, turn off on_insert = false
			on_insert = true,
			on_insert_follow = true,
		},
		code_action = {
			extend_gitsigns = false,
		},
		lightbulb = {
			debounce = 500,
		},
	})

	-- lsp finder to find the cursor word definition and reference
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

	-- code action
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")

	-- definition
	vim.keymap.set("n", "pd", "<cmd>Lspsaga peek_definition<R>")
	vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

	vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

	-- Show cursor diagnostic
	vim.keymap.set("n", "<leader>sv", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

	-- hover dock
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
	-- Outline
	vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
	-- rename
	vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>")

	-- show signature help
	-- vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help)

	-- Diagnsotic jump can use `<c-o>` to jump back
	vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

	-- or jump to error
	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)

	-- float terminal also you can pass the cli command in open_float_terminal function
	vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
	vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga term_toggle<CR>]])
end

return M
