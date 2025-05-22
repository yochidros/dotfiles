local M = {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		{
			"vim-denops/denops.vim",
			config = function()
				vim.g["denops#deno"] = "/opt/homebrew/bin/deno"
				vim.g["denops#server#deno_arg"] = { "-q", "--no-lock", "-A", "--allow-import" }
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
	})
	vim.keymap.set({ "i" }, "<C-x>", "<Plug>(skkeleton-toggle)")
end

return M
