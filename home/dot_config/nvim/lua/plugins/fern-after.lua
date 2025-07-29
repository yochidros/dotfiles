local M = {
	"lambdalisue/fern-renderer-nerdfont.vim",
	event = "VeryLazy",
	dependencies = {
		"lambdalisue/glyph-palette.vim",
		{ "yuki-yano/fern-preview.vim", event = "BufReadPost" },
		{ "lambdalisue/fern-git-status.vim", event = "BufReadPost" },
	},
}

function M.config()
	vim.cmd('let g:fern#renderer = "nerdfont"')
	-- ---
	local glyph_palette_augroup = vim.api.nvim_create_augroup("my-glyph-palette", { clear = true })

	-- Apply glyph_palette for 'fern' filetype
	vim.api.nvim_create_autocmd("FileType", {
		group = glyph_palette_augroup,
		pattern = "fern",
		callback = function()
			vim.fn["glyph_palette#apply"]()
		end,
		desc = "Apply glyph palette for Fern filetype",
	})

	-- Apply glyph_palette for 'nerdtree' and 'startify' filetypes
	vim.api.nvim_create_autocmd("FileType", {
		group = glyph_palette_augroup,
		pattern = { "nerdtree", "startify" },
		callback = function()
			vim.fn["glyph_palette#apply"]()
		end,
		desc = "Apply glyph palette for NERDTree and Startify filetypes",
	})

	-- ---
	-- Fern Settings and Keymaps
	-- ---

	-- Define a local function to set up Fern-specific mappings
	local function setup_fern_settings()
		-- Helper function for common keymap options
		local function map_fern_key(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, {
				silent = true,
				buffer = true, -- These mappings are buffer-local to the Fern window
				desc = "Fern: " .. desc,
			})
		end

		map_fern_key("p", "<Plug>(fern-action-preview:toggle)", "Toggle preview")
		map_fern_key("<C-p>", "<Plug>(fern-action-preview:auto:toggle)", "Toggle auto-preview")
		map_fern_key("<C-d>", "<Plug>(fern-action-preview:scroll:down:half)", "Scroll preview down half page")
		map_fern_key("<C-u>", "<Plug>(fern-action-preview:scroll:up:half)", "Scroll preview up half page")
		map_fern_key("<C-r>", "<Plug>(fern-action-trash=)", "Trash file")
		map_fern_key("<C-l>", "<C-w>l", "Move to next window") -- This is a standard Neovim window command

		-- Split commands
		map_fern_key("<C-A-d>", "<Plug>(fern-action-cd)", "change directory")
		map_fern_key("<C-A-l>", "<Plug>(fern-action-open:vsplit)", "Open in vertical split")
		map_fern_key("<C-A-j>", "<Plug>(fern-action-open:split)", "Open in horizontal split")
	end

	-- Create or clear the autogroup for Fern settings
	local fern_settings_augroup = vim.api.nvim_create_augroup("fern_settings", { clear = true })

	-- Autocmd to call the setup_fern_settings function when the filetype is 'fern'
	vim.api.nvim_create_autocmd("FileType", {
		group = fern_settings_augroup,
		pattern = "fern",
		callback = setup_fern_settings, -- Directly reference the Lua function
		desc = "Apply Fern specific settings and keymaps",
	})
end

return M
