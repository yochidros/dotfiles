local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
	},
}

function M.config()
	vim.g.copilot_proxy_strict_ssl = false
	require("copilot").setup({
		suggestion = { enabled = false, debounce = 1 },
		panel = { enabled = false },
		nes = { enabled = false },
	})
end
return M
