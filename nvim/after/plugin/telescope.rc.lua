local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local telescope = require("telescope")
-- Telescope
telescope.setup({
	defaults = {
		layout_config = {
			vertical = { width = 1.0 },
			-- other layout configuration here
		},
		-- other defaults configuration here
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		["ui-select"] = {
			themes.get_dropdown({
				-- even more opts
			}),
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { silent = true, noremap = true })
vim.keymap.set("n", "<C-g>", require("telescope.builtin").live_grep, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { silent = true, noremap = true })

vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 220 })
-- vim.api.nvim_set_hl(0, "TelescopeTitle", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { ctermbg = 220 })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { ctermbg = 220, fg = "#cc241d" })
