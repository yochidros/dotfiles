local function setup()
	vim.g.lightline_skk_announce = true
	local dark_theme = require("lualine.themes.gruvbox_dark")
	local light_theme = require("lualine.themes.gruvbox_light")
	local _ = require("config.dark_mode")
	local theme = light_theme
	if is_dark_mode then
		theme = dark_theme
	end
	require("lualine").setup({
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

local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	lazy = false,
	dependencies = {
		{
			"yasunori0418/statusline_skk.vim",
		},
	},
	opts = setup,
	refresh = setup,
}

return M
