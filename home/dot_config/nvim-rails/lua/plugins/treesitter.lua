local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = not vim.g.started_by_firenvim,
	event = "VeryLazy",
}

function M.config()
	if vim.g.started_by_firenvim then
		return
	end
	local status, treesitter = pcall(require, "nvim-treesitter.configs")
	if not status then
		return
	end
	-- Syntax highlight
	treesitter.setup({
		indent = {
			enable = false,
			disable = {},
		},
		auto_install = true,
		highlight = {
			enable = true,
			disable = {},
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},
	})
end

return M
