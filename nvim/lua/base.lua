vim.g.mapleader = " "
vim.g.LANG = "en"

local o = vim.o

-- 改行時に自動でコメントを挿入するのを防ぐ ""
vim.cmd [[
  "コマンドを全て除去
  "autocmd!
  autocmd FileType * setlocal formatoptions-=r
  autocmd FileType * setlocal formatoptions-=o
]]

-- Encoding
vim.scriptencoding = 'utf-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.fileencodings = 'utf-8'

o.bomb = true
o.binary = true
o.ttyfast = true

o.backspace = 'indent,eol,start'
o.number = true
o.rnu = true
o.ruler = true
o.showcmd = true
o.wildmenu = true
o.whichwrap = 'h,l,b,s,<,>,[,]'
o.mouse = 'a'

if vim.fn.has("maxunix") == 1 then
  o.clipboard:prepend { 'unnamed', 'unnamedplus' }
end

vim.t_Co = 256
vim.tapstop = 2

o.title = false
o.autoindent = true
o.si = true
o.shell = 'fish'
o.cmdheight = 1
o.showtabline = 1
vim.hidden = true

o.wrap = false
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
vim.nobackup = true
vim.noswapfile = true
o.fileformats = 'unix,dos,mac'
o.backupskip = '/tmp*,/private/tmp/*'
o.dictionary = '/usr/share/dict/words/'


-- completion
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

-- Podfileにrubyのsyntaxを当てる
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Podfile", "*.podspec" },
  command = "set filetype=ruby"
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste"
})
