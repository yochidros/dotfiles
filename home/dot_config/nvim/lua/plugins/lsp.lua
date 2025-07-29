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
		{
			"folke/lsp-colors.nvim",
			config = {
				Error = [[#db4b4b]],
				Warning = [[#e0af68]],
				Information = [[#0db9d7]],
				Hint = "#10B981",
			},
		},
		{ "williamboman/mason-lspconfig.nvim" },
		"saghen/blink.cmp",
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

	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	nvim_lsp.lua_ls.setup({
		cmd = { "lua-language-server", "--force-accept-workspace" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = {
						"vim",
						"require",
					},
				},
				hint = {
					enable = true,
				},
				format = {
					enable = false, -- Use StyLua
				},
				workspace = {
					ignoreDir = { "*" },
					checkThirdParty = false,
				},
				unusedLocalExclude = { "_*" },
			},
		},
	})

	nvim_lsp.clangd.setup({
		settings = {
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		},
	})
	nvim_lsp.harper_ls.setup({})

	nvim_lsp.gleam.setup({})

	-- swift
	nvim_lsp.sourcekit.setup({
		root_dir = function(filename, _)
			local util = nvim_lsp.util
			local root = util.root_pattern("buildServer.json")(filename)
				or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
				or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
				or util.root_pattern("Package.swift")(filename)
			if root then
				return root
			else
				return vim.fn.getcwd()
			end
		end,
		filetypes = { "swift", "objc", "objcpp" },
		cmd = { "sourcekit-lsp" },
	})

	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "clangd", "pylsp" },
		automatic_enable = {
			exclude = {
				"rust_analyzer",
				"ts_ls",
			},
		},
	})

	-- gleam formatting
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
