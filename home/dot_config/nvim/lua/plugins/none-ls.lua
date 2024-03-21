local M = {
	"nvimtools/none-ls.nvim",
}

function M.setup(capabilities)
	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	local null_ls = require("null-ls")

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		capabilities = capabilities,
		debug = true,
		sources = {
			-- Lua
			null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.diagnostics.eslint_d,
			-- null_ls.builtins.diagnostics.eslint_d.with({
			-- 	diagnostics_format = "[eslint] #{m}\n(#{c})",
			-- }),
			null_ls.builtins.formatting.prettierd,
			-- python
			-- null_ls.builtins.diagnostics.mypy,
			-- -- null_ls.builtins.diagnostics.flake8,
			-- null_ls.builtins.formatting.black,
			-- null_ls.builtins.formatting.isort,
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

	vim.api.nvim_create_autocmd("FileType", { pattern = "NullLsInfo", command = [[setlocal nofoldenable]] })
end

return M
