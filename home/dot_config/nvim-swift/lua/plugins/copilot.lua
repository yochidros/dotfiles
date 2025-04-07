local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
}

function M.config()
	vim.g.copilot_proxy_strict_ssl = false
	require("copilot").setup({
		server_opts_overrides = {
			trace = "verbose",
		},
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
end
return M
