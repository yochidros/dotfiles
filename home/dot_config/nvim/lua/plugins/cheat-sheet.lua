return {
	dir = vim.fn.stdpath("config") .. "/lua/cheat-sheet",
	name = "cheat-sheet",
	cmd = { "CheatSheet", "CheatSheetToggle" },
	keys = {
		{ "<leader>?", "<cmd>CheatSheetToggle<cr>", desc = "Toggle cheat sheet" },
		{ "<F1>", "<cmd>CheatSheetToggle<cr>", desc = "Toggle cheat sheet" },
	},
	config = function()
		require("cheat-sheet").setup({
			window = {
				width = 100,
				height = 40,
				border = "rounded",
				title = " Command Cheat Sheet ",
			},
			search = {
				prompt = "Search commands: ",
				case_sensitive = false,
			},
			categories = {
				show_all = true,
				default_category = "basic",
			},
			keymaps = {
				close = { "q", "<Esc>" },
				execute = { "<CR>" },
				copy = { "y" },
			},
		})
	end,
}