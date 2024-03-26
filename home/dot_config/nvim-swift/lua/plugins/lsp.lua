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
		{
			"lvimuser/lsp-inlayhints.nvim",
			config = function()
				require("lsp-inlayhints").setup()
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },
		"hrsh7th/cmp-nvim-lsp",
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					bind = true,
					handler_opts = {
						border = "rounded",
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
	local nvim_s, nvim_lsp = pcall(require, "lspconfig")
	if not nvim_s then
		return
	end
	require("lspconfig.ui.windows").default_options.border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	require("mason-lspconfig").setup()
	local handlers = {
		function(server_name) -- default handler (optional)
			nvim_lsp[server_name].setup({
				capabilities = capabilities,
			})
		end,
		-- Next, you can provide targeted overrides for specific servers.
		["rust_analyzer"] = function()
			-- require("rust-tools").setup({})
		end,
		["tsserver"] = function()
			require("plugins.typescript-tools").setup_local({
				capabilities = capabilities,
			})
		end,
		["clangd"] = function()
			capabilities.offsetEncoding = { "utf-16" }
			nvim_lsp.clangd.setup({
				capabilities = capabilities,
			})
		end,
		["solargraph"] = function()
			local home_path = vim.fn.expand("$HOME/")
			nvim_lsp.solargraph.setup({
				capabilities = capabilities,
				init_options = {
					formatting = true,
				},
				settings = {
					solargraph = {
						commandPath = home_path .. "/.rbenv/shims/solargraph",
						diagnostics = true,
						useBundler = false,
						bundlerPath = home_path .. "/.rbenv/shims/bundler",
					},
				},
			})
		end,
	}
	require("mason-lspconfig").setup_handlers(handlers)

	-- swift
	nvim_lsp.sourcekit.setup({
		capabilities = capabilities,
		root_dir = function(filename, _)
			local util = nvim_lsp.util
			local root = util.root_pattern("buildServer.json")(filename)
				or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
				or util.find_git_ancestor(filename)
				or util.root_pattern("Package.swift")(filename)
			if root then
				return root
			else
				return vim.fn.getcwd()
			end
		end,
		filetypes = { "swift", "objective-c", "objective-cpp", "objcpp" },
		cmd = { "xcrun", "sourcekit-lsp" },
	})

	vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = "LspAttach_inlayhints",
		callback = function(args)
			if not (args.data and args.data.client_id) then
				return
			end

			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			require("lsp-inlayhints").on_attach(client, bufnr)
		end,
	})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local bufnr = ev.buf

			require("lsp_signature").on_attach({}, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<C-i>", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<space>wl", function() end, bufopts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end,
	})

	require("plugins.none-ls").setup(capabilities)
end

return M
