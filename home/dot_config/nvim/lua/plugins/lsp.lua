local function contains(table, val)
	for _, value in ipairs(table) do
		if value == val then
			return true
		end
	end
	return false
end

local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "LSP",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
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
					max_width = 150,
					auto_close_after = 1000,
					close_timeout = 2000,
					zindex = 50,
					shadow_guibg = "Green",
					shadow_blend = 0,
					toggle_key = "<M-X>",
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
		["pylsp"] = function()
			nvim_lsp.pylsp.setup({
				capabilities = capabilities,
			})
		end,
		["rust_analyzer"] = function()
			-- automatically setup via rustacean.nvim
		end,
		["clangd"] = function()
			capabilities.offsetEncoding = { "utf-16" }
			nvim_lsp.clangd.setup({
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "swift" },
			})
		end,
		["lua_ls"] = function()
			require("neodev").setup()
			nvim_lsp.lua_ls.setup({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						hint = {
							enable = true,
						},
						format = {
							enable = false, -- Use StyLua
						},
						workspace = {
							checkThirdParty = false,
						},
						unusedLocalExclude = { "_*" },
					})
				end,
				capabilities = capabilities,
			})
		end,
	}
	require("mason-lspconfig").setup_handlers(handlers)

	nvim_lsp.gleam.setup({
		capabilities = capabilities,
	})
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
		filetypes = { "swift", "objc", "objcpp" },
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
			if client then
				require("lsp-inlayhints").on_attach(client, bufnr)
			end
		end,
	})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local bufnr = ev.buf
			local clients = vim.lsp.get_clients({
				id = ev.data.client_id,
				bufnr = bufnr,
			})

			if #clients > 0 and contains({ "gleam" }, clients[1].name) then
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							async = false,
						})
						require("fidget").notify("LSP Formatted!!", vim.log.levels.INFO)
					end,
				})
			end

			require("lsp_signature").on_attach({}, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<M-x>", vim.lsp.buf.signature_help, bufopts)
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
end

return M
