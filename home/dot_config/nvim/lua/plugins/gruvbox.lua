local M = {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 999,
}
function M.config()
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "hard", -- can be "hard", "soft" or empty string
		palette_overrides = {
			-- dark2 = "#1d2021",
		},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	})
	vim.cmd("colorscheme gruvbox")
end

return M
