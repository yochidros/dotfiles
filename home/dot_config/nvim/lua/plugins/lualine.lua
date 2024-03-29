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
	local gruvbox = {
		normal = {
			a = { bg = colors.gray, fg = colors.black, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		insert = {
			a = { bg = colors.blue, fg = colors.black, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.white },
		},
		visual = {
			a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.black },
		},
		replace = {
			a = { bg = colors.red, fg = colors.black, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.white },
			c = { bg = colors.black, fg = colors.white },
		},
		command = {
			a = { bg = colors.green, fg = colors.black, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.black },
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.lightgray, gui = "bold" },
			b = { bg = colors.darkgray, fg = colors.lightgray },
			c = { bg = colors.darkgray, fg = colors.lightgray },
		},
	}
	if vim.g.started_by_firenvim then
		lualine.setup({
			options = {
				icon_enabled = false,
				theme = gruvbox,
				-- theme = "auto",
				disable_filetypes = {},
				-- section_separators = { "", "" },
				-- component_separators = { "", "" },
			},
			sections = {
				lualine_a = { "mode", "statusline_skk#mode" },
				lualine_b = {},
				lualine_c = {
					"os.date('%H:%M:%S')",
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "encoding" },
			},
		})
	else
		lualine.setup({
			options = {
				icon_enabled = true,
				theme = gruvbox,
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
end

return M
