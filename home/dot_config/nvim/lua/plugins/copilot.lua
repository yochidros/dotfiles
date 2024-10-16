local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
}

function M.config()
	vim.g.copilot_proxy_strict_ssl = false
	require("copilot").setup({
		suggestion = { enabled = false, debounce = 1 },
		panel = { enabled = false },
	})
end
return M
