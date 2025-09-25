local M = {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		{
			"vim-denops/denops.vim",
			tag = "v8.0.0",
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
		showCandidatesCount = 1,
		globalDictionaries = {
			dict .. "SKK-JISYO.S",
			dict .. "SKK-JISYO.emoji.utf8",
		},
		sources = {
			"skk_dictionary",
			"skk_server",
		},
		skkServerPort = 1179,
		keepState = true,
		markerHenkan = "▽ ",
		markerHenkanSelect = "▼ ",
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
