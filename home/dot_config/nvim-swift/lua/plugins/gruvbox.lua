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
		inverse = false, -- invert background for search, diffs, statuslines and errors
		contrast = "hard", -- can be "hard", "soft" or empty string
		palette_overrides = {
			-- dark2 = "#1d2021",
		},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	})
	vim.cmd("colorscheme gruvbox")
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white" })
end

return M
--
-- M.colors = {
--   dark0_hard = "#1d2021",
--   dark0 = "#282828",
--   dark0_soft = "#32302f",
--   dark1 = "#3c3836",
--   dark2 = "#504945",
--   dark3 = "#665c54",
--   dark4 = "#7c6f64",
--   light0_hard = "#f9f5d7",
--   light0 = "#fbf1c7",
--   light0_soft = "#f2e5bc",
--   light1 = "#ebdbb2",
--   light2 = "#d5c4a1",
--   light3 = "#bdae93",
--   light4 = "#a89984",
--   bright_red = "#fb4934",
--   bright_green = "#b8bb26",
--   bright_yellow = "#fabd2f",
--   bright_blue = "#83a598",
--   bright_purple = "#d3869b",
--   bright_aqua = "#8ec07c",
--   bright_orange = "#fe8019",
--   neutral_red = "#cc241d",
--   neutral_green = "#98971a",
--   neutral_yellow = "#d79921",
--   neutral_blue = "#458588",
--   neutral_purple = "#b16286",
--   neutral_aqua = "#689d6a",
--   neutral_orange = "#d65d0e",
--   faded_red = "#9d0006",
--   faded_green = "#79740e",
--   faded_yellow = "#b57614",
--   faded_blue = "#076678",
--   faded_purple = "#8f3f71",
--   faded_aqua = "#427b58",
--   faded_orange = "#af3a03",
--   gray = "#928374",
-- }
