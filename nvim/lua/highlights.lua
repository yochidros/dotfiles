vim.opt.background = 'dark'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.cmd('let base16colorspace=256') --Access colors present in 256 colorspace

vim.opt.termguicolors = true

vim.cmd('highlight Comment guibg=NONE guifg=#A4E57E')
vim.cmd('highlight CursorColumn term=underline cterm=underline ctermfg=NONE guifg=NONE guibg=gray46')
vim.cmd('highlight CursorLine term=underline gui=underline cterm=underline ctermfg=NONE guifg=NONE')
