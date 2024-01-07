local M = {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		"vim-denops/denops.vim",
	},
}

function M.config()
	local dict = "~/Library/Application Support/AquaSKK/"
	vim.fn["skkeleton#config"]({
		eggLikeNewline = true,
		debug = true,
		immediatelyCancel = false,
		globalDictionaries = {
			dict .. "SKK-JISYO.L",
			dict .. "SKK-JISYO.jinmei",
			dict .. "SKK-JISYO.geo",
			dict .. "SKK-JISYO.station",
			dict .. "SKK-JISYO.propernoun",
			dict .. "SKK-JISYO.jawiki",
			dict .. "SKK-JISYO.neologd",
		},
		keepState = false,
		markerHenkan = "▽ ",
		markerHenkanSelect = "▼ ",
		useGoogleJapaneseInput = true,
		usePopup = true,
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
