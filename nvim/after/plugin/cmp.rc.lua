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

cmp.setup({
	enabled = function()
		local context = require("cmp.config.context")
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = {
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
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end,
	},
	experimental = {
		ghost_text = true,
	},
	view = {
		entries = "custom", --"native"
	},
	window = {
		-- document window border
		documentation = {
			winhighlight = "Normal:PmenuSelect,FloatBorder:PmenuSelect,CursorLine:Visual,Search:None",
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		completion = {
			winhighlight = "Normal:PmenuSelect,FloatBorder:PmenuSelect,CursorLine:Visual,Search:None",
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	formatting = {
		-- fields = { "kind", "abbr", "menu" },
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

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  inoremap <expr> <Tab>   pumvisible() ? "<C-n>" : "<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"
  imap <expr> <C-l>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"

  highlight! default link CmpItemKind CmpItemMenuDefault
  highlight! CmpItemAbbr guibg=NONE guifg=NONE
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
