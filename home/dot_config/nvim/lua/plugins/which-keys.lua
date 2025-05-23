local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>h",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Show which-key menu",
		},
		{
			"<space>q",
			function()
				vim.diagnostic.setloclist()
			end,
			desc = "Show diagnostics",
		},
		{ "<C-M-H>", desc = "resize left" },
		{ "<C-M-J>", desc = "resize down" },
		{ "<C-M-K>", desc = "resize up" },
		{ "<C-M-L>", desc = "resize right" },
		{ "<leader><leader>h", desc = "swap left" },
		{ "<leader><leader>j", desc = "swap down" },
		{ "<leader><leader>k", desc = "swap up" },
		{ "<leader><leader>l", desc = "swap right" },
	},
}
return M
