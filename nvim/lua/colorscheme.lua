vim.api.nvim_command([[
  let g:gruvbox_contrast_dark = 'hard'
]])
vim.cmd("colorscheme base16-gruvbox-dark-hard")

vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
