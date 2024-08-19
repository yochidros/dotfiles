local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	lazy = false,
	dependencies = {
		{
			"yasunori0418/statusline_skk.vim",
		},
	},
}

function M.config()
	local status, lualine = pcall(require, "lualine")
	if not status then
		return
	end

	vim.g.lightline_skk_announce = true
	local colors = {
		black = "#282828",
		white = "#ebdbb2",
		red = "#fb4934",
		green = "#b8bb26",
		blue = "#83a598",
		yellow = "#fe8019",
		gray = "#a89984",
		darkgray = "#1d2021",
		lightgray = "#3c3836",
		inactivegray = "#7c6f64",
	}
	local dark_theme = require("lualine.themes.gruvbox_dark")
	local light_theme = require("lualine.themes.gruvbox_light")
	local _ = require("config.dark_mode")
	local theme = light_theme
	if is_dark_mode then
		theme = dark_theme
	end
	lualine.setup({
		options = {
			icon_enabled = true,
			theme = theme,
			disable_filetypes = {},
		},
		sections = {
			lualine_a = { "mode", "statusline_skk#mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"os.date('%H:%M:%S')",
				"filename",
				"require'lsp-status'.status()",
			},
		},
		extensions = { "fugitive", "fern" },
	})
end

return M
