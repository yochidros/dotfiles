local M = {
	"johnfrankmorgan/whitespace.nvim",
	event = "VeryLazy",
	config = function()
		require("whitespace-nvim").setup({
			-- configuration options and their defaults

			-- `highlight` configures which highlight is used to display
			-- trailing whitespace
			highlight = "TodoBgFIX",

			-- `ignored_filetypes` configures which filetypes to ignore when
			-- displaying trailing whitespace
			ignored_filetypes = {
				"TelescopePrompt",
				"Trouble",
				"help",
				"Comment",
				"lazy",
				"lspinfo",
				"mason",
			},

			-- `ignore_terminal` configures whether to ignore terminal buffers
			ignore_terminal = true,
		})
		vim.keymap.set("n", "<leader>i", require("whitespace-nvim").trim)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				require("whitespace-nvim").trim()
			end,
		})
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufReadPost", "InsertEnter" }, {
			pattern = "*",
			callback = function()
				require("whitespace-nvim").highlight()
			end,
		})
	end,
}
return M
