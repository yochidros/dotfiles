-- LSP
local lsp_s, lsp_status = pcall(require, "lsp-status")
if not lsp_s then
	return
end
local nvim_s, nvim_lsp = pcall(require, "lspconfig")
if not nvim_s then
	return
end

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- LSP enable formatting
	-- if client.server_capabilities.documentFormattingProvider then
	--   vim.api.nvim_command [[augroup Format]]
	--   vim.api.nvim_command [[autocmd! * <buffer>]]
	--   vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
	--   vim.api.nvim_command [[augroup END]]
	-- end
	-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	--
	-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	require("lsp_signature").on_attach({}, bufnr)
	lsp_status.on_attach(client)

	-- Mappings
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
end

-- local lsp_flags = {
--   -- This is the default in Nvim 0.7+
--   debounce_text_changes = 300,
-- }

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

-- rust-analyzer

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			diagnostic = {
				disabled = { "missing-unsafe" },
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

-- swift
nvim_lsp.sourcekit.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.fn.getcwd()
	end,
})

nvim_lsp.sorbet.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "srb", "tc", "--typed=true", "--lsp" },
})
nvim_lsp.solargraph.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/Users/yochidros/.rbenv/shims/solargraph", "stdio" },
	init_options = {
		formatting = true,
	},
	settings = {
		solargraph = {
			commandPath = "/Users/yochidros/.rbenv/shims/solargraph",
			diagnostics = true,
			useBundler = true,
			bundlerPath = "/Users/yochidros/.rbenv/shims/bundler",
		},
	},
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/Users/yochidros/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	capabilities = capabilities,
})

nvim_lsp.hls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		haskell = {
			maxCompletions = 20,
			completionSnippetsOn = false,
		},
	},
})

local servers = { "pyright", "gopls", "kotlin_language_server", "eslint" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

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
		-- python
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		-- Rust
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
