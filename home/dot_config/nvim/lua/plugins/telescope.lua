local M = {
	"nvim-telescope/telescope.nvim",
	-- tag = "0.1.8",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"jonarrien/telescope-cmdline.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
}

function M.config()
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
				n = {
					["cd"] = function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						local dir = vim.fn.fnamemodify(selection.path, ":p:h")
						require("telescope.actions").close(prompt_bufnr)
						-- Depending on what you want put `cd`, `lcd`, `tcd`
						vim.cmd(string.format("silent lcd %s", dir))
					end,
				},
			},
		},
	})
	telescope.load_extension("ui-select")
	telescope.load_extension("cmdline")
	telescope.load_extension("file_browser")
	vim.keymap.set("n", "<leader>ff", M["find_files"], {})
	vim.keymap.set("n", "<C-g>", M["live_grep"], {})
	vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})
	vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})
	vim.keymap.set("n", "<leader>fc", ":silent Telescope cmdline<CR>", { noremap = true, desc = "Cmdline" })
	vim.keymap.set(
		"n",
		"<leader>fp",
		M["file_browser_insert_path"],
		{ noremap = true, desc = "File Browser insert_path" }
	)

	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { ctermbg = 255 })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 255 })
	vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
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

function M.file_browser_insert_path()
	require("telescope").extensions.file_browser.file_browser({
		attach_mappings = function(_, map)
			map("i", "i", function(prompt_bufnr)
				local entry = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				if entry and entry.path then
					vim.api.nvim_put({ entry.path }, "", false, true)
				end
			end)
			map("n", "i", function(prompt_bufnr)
				local entry = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				if entry and entry.path then
					vim.api.nvim_put({ entry.path }, "", false, true)
				end
			end)
			return true
		end,
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
