local M = {
	"nvimtools/none-ls.nvim",
}

function M.setup(options)
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
		sources = {
			-- Lua
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.eslint_d,
			-- null_ls.builtins.diagnostics.eslint_d.with({
			-- 	diagnostics_format = "[eslint] #{m}\n(#{c})",
			-- }),
			null_ls.builtins.formatting.prettierd,
			-- python
			-- null_ls.builtins.diagnostics.mypy,
			null_ls.builtins.diagnostics.flake8,
			-- null_ls.builtins.formatting.black,
			-- null_ls.builtins.formatting.isort,
			-- ruby
			null_ls.builtins.diagnostics.rubocop,
			null_ls.builtins.formatting.rufo,
			-- Rust
			null_ls.builtins.formatting.clang_format,
			null_ls.builtins.formatting.rustfmt.with({
				extra_args = function(params)
					local Path = require("plenary.path")
					local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

					if cargo_toml:exists() and cargo_toml:is_file() then
						for _, line in ipairs(cargo_toml:readlines()) do
							local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
							if edition then
								return { "--edition=" .. edition }
							end
						end
					end
					-- default edition when we don't find `Cargo.toml` or the `edition` in it.
					return { "--edition=2021" }
				end,
			}),
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
