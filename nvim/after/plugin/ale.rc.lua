-- ale
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_virtualtext_prefix = ' --> '
vim.g.ale_list_window_size = 5
vim.g.ale_sign_warning = '🔔'

vim.g.ale_linters = {
  ['javascript'] = { 'eslint' },
  ['go'] = { 'golint', 'govet', 'errcheck' },
  ['python'] = { 'pyflakes', 'pep8' },
  ['ruby'] = { 'rubocop' },
  ['haskell'] = { 'hie' },
  ['markdown'] = { 'textlint' },
  ['rust'] = { 'analyzer' },
  ['swift'] = { 'swift-format' }
}

-- 自動補完を有効
vim.g.ale_completion_enabled = 0
-- 保存時に自動整形
vim.g.ale_fix_on_save = 1
vim.g.vim_swift_format_use_ale = 1
