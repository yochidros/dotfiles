local M = {
	"hrsh7th/cmp-nvim-lsp",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			"onsails/lspkind-nvim",
			config = function()
				local status, lspkind = pcall(require, "lspkind")
				if not status then
					return
				end

				lspkind.init({
					mode = "symbol_text",
					preset = "codicons",
					symbol_map = {
						Text = "",
						Method = "",
						Function = "",
						Constructor = "",
						Field = "ﰠ",
						Variable = "",
						Class = "ﴯ",
						Interface = "",
						Module = "",
						Property = "ﰠ",
						Unit = "塞",
						Value = "",
						Enum = "",
						Keyword = "",
						Snippet = "",
						Color = "",
						File = "",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "פּ",
						Event = "",
						Operator = "",
						Copilot = "ﯙ",
						TypeParameter = "",
					},
				})
			end,
		},
		{ "delphinus/cmp-skkeleton2", branch = "fix/method-name" },
		"hrsh7th/cmp-vsnip",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.1.1",
			build = "make install_jsregexp",
		},
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		},
		-- {
		-- 	"zbirenbaum/copilot-cmp",
		-- 	dependencies = { "copilot.lua" },
		-- 	config = function()
		-- 		require("copilot_cmp").setup()
		-- 	end,
		-- },
	},
}

function M.config()
	local status, cmp = pcall(require, "cmp")
	if not status then
		return
	end

	local lspkind = require("lspkind")
	-- showin completion window if input `backspace` re-suggestion
	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local has_words_before = function()
		if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
	end
	local enabled = function()
		local context = require("cmp.config.context")
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end
	local mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end),
	}
	local completion = {
		completeopt = "menu,menuone,noinsert",
	}
	local experimental = {
		ghost_text = true,
	}
	local sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" }, -- github copitlot
		{ name = "buffer" },
		{ name = "skkeleton" },
	}
	if vim.g.started_by_firenvim then
		cmp.setup({
			enabled = enabled,
			sources = cmp.config.sources(sources),
			completion = completion,
			mapping = mapping,
			experimental = experimental,
		})
	else
		cmp.setup({
			enabled = enabled,
			sources = cmp.config.sources({
				unpack(sources),
				{ name = "nvim_lsp_signature_help" },
				{ name = "path" },
				{ name = "luasnip" },
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			completion = completion,
			mapping = mapping,
			experimental = experimental,
			window = {
				-- document window border
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered(),
			},
			formatting = {
				format = function(entry, vim_item)
					local _f = lspkind.cmp_format({ wirth_text = false, maxwidth = 40 })
					vim_item.menu = ({
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return _f(entry, vim_item)
				end,
			},
		})
	end

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline({
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-p>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		}),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = {
						"q",
						"qa",
						"wq",
						"wqa",
						"w",
						"w!",
						"wa",
						"wa!",
						"!",
						"Man",
					},
				},
			},
		}),
	})

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local handlers = require("nvim-autopairs.completion.handlers")

	cmp.event:on(
		"confirm_done",
		cmp_autopairs.on_confirm_done({
			filetypes = {
				-- "*" is a alias to all filetypes
				["*"] = {
					["("] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						handler = handlers["*"],
					},
				},
				lua = {
					["("] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						---@param char string
						---@param item item completion
						---@param bufnr buffer number
						handler = function(char, item, bufnr)
							-- print(vim.inspect({ char, item, bufnr }))
							-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
						end,
					},
				},
				-- Disable for tex
				tex = false,
			},
		})
	)
end

return M
