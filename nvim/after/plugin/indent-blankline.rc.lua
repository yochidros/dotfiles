vim.opt.list = true
vim.opt.listchars = {}
vim.opt.listchars:append("tab:▸ ")
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = false,
	show_end_of_line = true,
})
