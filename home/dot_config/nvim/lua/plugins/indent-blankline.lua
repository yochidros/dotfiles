local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
}

function M.config()
	local status, blankline = pcall(require, "indent_blankline")
	if not status then
		return
	end

	vim.opt.list = true
	vim.opt.listchars = {}
	vim.opt.listchars:append("tab:▸ ")
	vim.opt.listchars:append("space:⋅")
	vim.opt.listchars:append("eol:↴")

	blankline.setup({
		show_current_context = true,
		show_current_context_start = false,
		show_end_of_line = true,
	})
end

return M
