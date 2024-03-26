local M = {
	"aspeddro/gitui.nvim",
	event = "VeryLazy",
	opt = {},
}

function M.config()
	require("gitui").setup()
end

return M
