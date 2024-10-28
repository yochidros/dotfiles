local M = {
	"vim-skk/skkeleton",
	lazy = false,
	commit = "8d0b7337013e466c578e024b7c8e5b5d297f0a3e", -- kowareteru
	dependencies = {
		{
			"vim-denops/denops.vim",
			config = function()
				vim.g["denops#deno"] = "/opt/homebrew/bin/deno"
			end,
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
		usePopup = true,
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
