local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
}

function M.config()
	require("copilot").setup({})
end
return M
