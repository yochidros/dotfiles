vim.g.mapleader = " "
vim.g.LANG = "en_US.UTF-8"

local o = vim.o

-- 改行時に自動でコメントを挿入するのを防ぐ
vim.api.nvim_create_autocmd({ "FileType" }, { command = "setlocal formatoptions-=r" })
vim.api.nvim_create_autocmd({ "FileType" }, { command = "setlocal formatoptions-=o" })

-- Encoding
vim.scriptencoding = "utf-8"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.fileencodings = "utf-8"

o.bomb = true
o.binary = true
o.ttyfast = true

o.backspace = "indent,eol,start"
o.number = true
o.rnu = true
o.ruler = true
o.showcmd = true
o.wildmenu = true
o.whichwrap = "h,l,b,s,<,>,[,]"
o.mouse = "a"

if vim.fn.has("macunix") == 1 then
	o.clipboard = "unnamed,unnamedplus"
end

vim.t_Co = 256
vim.tapstop = 2

o.title = false
o.autoindent = true
o.si = true
o.shell = "fish"
o.showtabline = 1
vim.hidden = true

o.wrap = false
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smarttab = true

-- Searching
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.wrapscan = true

-- backups
o.backup = false
o.swapfile = false
o.fileformats = "unix,dos,mac"
o.backupskip = "/tmp*,/private/tmp/*"
o.dictionary = "/usr/share/dict/words/"
o.cmdheight = 1
--o.loaded_perl_provider = false

-- completion
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldmethod = "indent"
o.foldlevelstart = 99
o.laststatus = 3
-- o.foldlevel = 2

-- reload current source
vim.keymap.set("n", "<leader>rc", ":so $MYVIMRC<CR>", { silent = true, noremap = false })

-- Podfileにrubyのsyntaxを当てる
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Podfile", "*.podspec" },
	command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})
