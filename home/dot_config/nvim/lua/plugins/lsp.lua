local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "LSP",
	dependencies = {
		{
			"folke/lsp-colors.nvim",
			config = {
				Error = [[#db4b4b]],
				Warning = [[#e0af68]],
				Information = [[#0db9d7]],
				Hint = "#10B981",
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"nvim-lua/lsp_extensions.nvim",
			config = function()
				vim.keymap.set(
					"n",
					"<leader>T",
					require("lsp_extensions").inlay_hints,
					{ noremap = true, silent = true }
				)
			end,
		},
		{
			"nvim-lua/lsp-status.nvim",
			config = function()
				local lsp_status = require("lsp-status")
				local kind_labels_mt = {
					__index = function(_, k)
						return k
					end,
				}
				local kind_labels = {}
				setmetatable(kind_labels, kind_labels_mt)
				lsp_status.register_progress()

				lsp_status.config({
					kind_labels = kind_labels,
				})

				vim.api.nvim_command([[
				   function! LspStatus() abort
				    if luaeval('#vim.lsp.buf_get_clients() > 0')
				      return luaeval("require('lsp-status').status()")
				    endif
				      return ''
				   endfunction
        ]])
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					bind = true,
					handler_opts = {
						border = "shadow",
					},
					zindex = 50,
					shadow_guibg = "Green",
					shadow_blend = 0,
					toggle_key = "<M-x>",
				})
			end,
		},
	},
}

function M.config()
	-- LSP
	local lsp_s, lsp_status = pcall(require, "lsp-status")
	if not lsp_s then
		return
	end
	local kind_labels_mt = {
		__index = function(_, k)
			return k
		end,
	}
	local kind_labels = {}
	setmetatable(kind_labels, kind_labels_mt)
	lsp_status.register_progress()

	lsp_status.config({
		kind_labels = kind_labels,
	})

	vim.api.nvim_command([[
      function! LspStatus() abort
      if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
        endif
        return ''
        endfunction
        ]])
	require("mason-lspconfig").setup()
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
		require("lsp_signature").on_attach({}, bufnr)
		lsp_status.on_attach(client)

		-- Mappings
		-- See `:help vim.lsp.*` for documentation on any of the below functions

		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-i>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end

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
		root_dir = function(filename, _)
			local git_root = nvim_lsp.util.find_git_ancestor(filename)
			if git_root then
				return git_root
			else
				return vim.fn.getcwd()
			end
		end,
		filetypes = { "swift", "objective-c", "objective-cpp" },
		cmd = {
			"/Applications/Xcode-15.0.1-Release.Candidate.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
		},
	})

	-- nvim_lsp.sorbet.setup({
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	cmd = { "bundle", "exec", "srb", "tc", "--typed=true", "--lsp" },
	-- })
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
				useBundler = false,
				bundlerPath = "/Users/yochidros/.rbenv/shims/bundler",
			},
		},
	})

	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	nvim_lsp.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = {
			"/Users/yochidros/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server",
		},
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
					checkThirdParty = false,
				},
			},
		},
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
	local cap = capabilities
	cap.offsetEncoding = { "utf-16" }
	nvim_lsp.clangd.setup({
		on_attach = on_attach,
		capabilities = cap,
	})

	local servers = { "pylsp", "gopls", "kotlin_language_server", "cssls" }
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	require("plugins.rust-tools").setup()
	require("plugins.typescript-tools").setup_local({
		on_attach = on_attach,
		capabilities = capabilities,
	})
	require("plugins.null-ls").setup({})
end

return M
