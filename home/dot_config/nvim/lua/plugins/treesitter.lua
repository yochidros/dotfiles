local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
}

function M.config()
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
			max_file_lines = 12000,
		},
	})
end

return M
