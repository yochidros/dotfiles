local M = {
	"vim-skk/skkeleton",
	lazy = false,
	commit = "8d0b7337013e466c578e024b7c8e5b5d297f0a3e", -- kowareteru
	dependencies = {
		{
			"vim-denops/denops.vim",
			config = function()
				local home = vim.fn.expand("$HOME/")
				vim.g["denops#deno"] = home .. ".deno/bin/deno"
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
		globalDictionaries = {
			dict .. "SKK-JISYO.S",
			dict .. "SKK-JISYO.emoji.utf8",
		},
		sources = {
			"skk_dictionary",
			"google_japanese_input",
		},
		keepState = false,
		markerHenkan = "▽ ",
		markerHenkanSelect = "▼ ",
		usePopup = true,
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
