return {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("zen-mode").setup({
			window = {
				width = 180,
			},
			plugins = {
				wezterm = {
					enable = true,
				},
			},
		})
		vim.keymap.set("n", "<M-z>", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
	end,
}
