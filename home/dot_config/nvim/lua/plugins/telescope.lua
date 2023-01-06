local M = {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

function M.config()
	local themes = require("telescope.themes")
	local telescope = require("telescope")
	-- Telescope
	telescope.setup({
		defaults = {
			layout_config = {
				vertical = { width = 2.0 },
			},
			prompt_title = false,
			preview_title = false,
			results_title = false,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
			},
			mappings = {
				i = {
					["<C-h>"] = "which_key",
				},
			},
		},
		extensions = {
			["ui-select"] = {
				themes.get_dropdown({
					-- even more opts
				}),
			},
		},
	})
	telescope.load_extension("ui-select")
	vim.keymap.set("n", "<leader>ff", M["find_files"], { silent = true, noremap = true })
	vim.keymap.set("n", "<C-g>", M["live_grep"], { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { silent = true, noremap = true })

	-- TelescopeBorder xxx ctermbg=100 guifg=#1a1c1d guibg=#1a1c1d
	-- TelescopeNormal xxx guibg=#1a1c1d
	-- local =   TelescopeBorder = { default = true, link = "TelescopeNormal" },

	-- vim.api.nvim_set_hl(0, "TelescopeTitle", { ctermbg = 220 })

	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 255 })
	-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = 110 })
	-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { ctermbg = 220 })
	-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { ctermbg = 220 })
	-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { ctermbg = 220 })
	-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { ctermbg = 220 })
	-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { ctermbg = 220, fg = "#cc241d" })
end
function M.find_files()
	require("telescope.builtin").find_files({
		width = 1.0,
		prompt_title = false,
		preview_title = false,
		results_title = false,
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		multi_icon = "<>",
	})
end
function M.live_grep()
	require("telescope.builtin").live_grep({
		width = 1.0,
		prompt_title = false,
		preview_title = false,
		results_title = false,
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		multi_icon = "<>",
	})
end

return M
