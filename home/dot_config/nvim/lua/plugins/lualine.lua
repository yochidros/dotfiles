local function setup()
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
				{
					function()
						return " "
					end,
					color = function()
						local status = require("sidekick.status").get()
						if status then
							return status.kind == "Error" and "DiagnosticError"
								or status.busy and "DiagnosticWarn"
								or "Special"
						end
					end,
					cond = function()
						local status = require("sidekick.status")
						return status.get() ~= nil
					end,
				},
			},
		},
		extensions = { "fugitive", "fern" },
	})
end

local function opts(_, _)
	vim.g.lightline_skk_announce = true
	setup()
end

local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"yasunori0418/statusline_skk.vim",
		},
	},
	opts = opts,
	refresh = setup,
}

return M
