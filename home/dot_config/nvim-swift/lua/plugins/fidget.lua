local M = {
	"j-hui/fidget.nvim",
	lazy = false,
	opt = {},
}
function M.config()
	require("fidget").setup({
		notification = {
			window = {
				normal_hl = "Comment", -- Base highlight group in the notification window
				winblend = 30, -- Background color opacity in the notification window
				border = "rounded", -- Border around the notification window
				zindex = 45, -- Stacking priority of the notification window
				max_width = 200, -- Maximum width of the notification window
				max_height = 200, -- Maximum height of the notification window
				x_padding = 1, -- Padding from right edge of window boundary
				y_padding = 1, -- Padding from bottom edge of window boundary
				align = "bottom", -- How to align the notification window
				relative = "editor", -- What the notification window position is relative to
			},
		},
		integration = {
			["xcodebuild-nvim"] = {
				enable = false,
			},
		},
	})
end
return M
