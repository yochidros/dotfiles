local M = {
	"vim-skk/skkeleton",
	lazy = false,
	dependencies = {
		{
			"vim-denops/denops.vim",
			config = function()
				local home = vim.fn.expand("$HOME")
				vim.g["denops#deno"] = home .. "/.deno/bin/deno"
			end,
		},
	},
}

function M.config()
	local dict = "~/Library/Application Support/AquaSKK/"
	vim.fn["skkeleton#config"]({
		eggLikeNewline = true,
		debug = false,
		immediatelyCancel = false,
		globalDictionaries = {
			dict .. "SKK-JISYO.L",
			dict .. "SKK-JISYO.jinmei",
			dict .. "SKK-JISYO.geo",
			dict .. "SKK-JISYO.station",
			dict .. "SKK-JISYO.propernoun",
			dict .. "SKK-JISYO.jawiki",
			dict .. "SKK-JISYO.neologd",
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
	vim.api.nvim_exec("call skkeleton#register_keymap('input', 'L', 'abbrev')", false)
end

return M
