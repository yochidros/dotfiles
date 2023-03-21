local M = {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

function M.config()
	local themes = require("telescope.themes")
	local telescope = require("telescope")
	-- Telescope
	telescope.setup({
		defaults = {
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

	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 255 })
end
function M.find_files()
	require("telescope.builtin").find_files({
		width = 0.1,
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
		width = 0.1,
		preview_title = false,
		results_title = false,
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		multi_icon = "<>",
	})
end

return M