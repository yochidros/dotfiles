local M = {
	"vim-skk/skkeleton",
	-- これ以上に上げるとstreamsが見つからないエラーに遭遇する
	commit = "0e5a7dc5984e6043ee6d3af81e0d8dbb554dca70",
	lazy = false,
	dependencies = {
		{
			"vim-denops/denops.vim",
			config = function()
				vim.g["denops#deno"] = "/opt/homebrew/bin/deno"
			end,
		},
		{
			"delphinus/skkeleton_indicator.nvim",
			opts = {
				abbrevHlName = "SkkeletonIndicatorHankata",
				eijiText = "A1",
				hiraText = "あ",
				kataText = "ア",
				abbrevText = "Aa",
				border = "none",
			},
		},
	},
}

function M.config()
	local dict = "~/yaskkserv/"
	vim.fn["skkeleton#config"]({
		eggLikeNewline = true,
		debug = false,
		immediatelyCancel = false,
		globalDictionaries = {
			dict .. "SKK-JISYO.S",
			dict .. "SKK-JISYO.emoji.utf8",
		},
		sources = {
			"skk_dictionary",
			"skk_server",
		},
		skkServerPort = 1179,
		keepState = false,
		markerHenkan = "▽ ",
		markerHenkanSelect = "▼ ",
		usePopup = true,
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
