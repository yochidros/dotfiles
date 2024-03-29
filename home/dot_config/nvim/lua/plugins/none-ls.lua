local M = {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}

function M.config()
	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
			async = false,
		})
	end

	local null_ls = require("null-ls")

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		capabilities = capabilities,
		debug = true,
		sources = {
			-- Lua
			null_ls.builtins.formatting.stylua,
			require("none-ls.diagnostics.eslint_d").with({
				diagnostics_format = "[eslint] #{m}\n#{c}",
			}),
			require("none-ls.code_actions.eslint_d"),
			null_ls.builtins.formatting.prettierd,
			-- python
			require("none-ls.diagnostics.flake8"),
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.isort,
			-- swift
			null_ls.builtins.diagnostics.swiftlint,
			null_ls.builtins.formatting.swiftformat,
			-- ruby
			null_ls.builtins.diagnostics.rubocop,
			null_ls.builtins.formatting.rufo,
			-- Rust
			null_ls.builtins.formatting.clang_format,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end,
	})
end

return M
