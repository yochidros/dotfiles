local M = {
	"pwntester/octo.nvim",
	event = "VeryLazy",
	command = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
function M.config()
	local git_root = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
	if string.match(git_root, "not a git repository") then
		return
	end
	local status, octo = pcall(require, "octo")
	if not status then
		return
	end
	octo.setup()
end
return M
