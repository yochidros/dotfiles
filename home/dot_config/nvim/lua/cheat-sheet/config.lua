local M = {}

M.defaults = {
	window = {
		width = 100,
		height = 40,
		border = "rounded",
		title = " Command Cheat Sheet ",
		row = nil,
		col = nil,
	},
	search = {
		prompt = "Search commands: ",
		case_sensitive = false,
		fuzzy = true,
	},
	categories = {
		show_all = true,
		default_category = "basic",
		enabled = {
			"basic",
			"movement",
			"editing",
			"visual",
			"search",
			"buffers",
			"windows",
			"git",
			"lsp",
			"telescope",
			"treesitter",
			"debugging",
			"terminal",
			"folding",
			"marks",
			"macros",
		},
	},
	keymaps = {
		close = { "q", "<Esc>" },
		execute = { "<CR>" },
		copy = { "y" },
		next_category = { "<Tab>" },
		prev_category = { "<S-Tab>" },
		clear_search = { "<C-u>" },
	},
	highlight = {
		border = "FloatBorder",
		title = "FloatTitle",
		category = "Title",
		command = "Function",
		description = "Comment",
		key = "String",
	},
}

M.options = {}

M.setup = function(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M