local home = vim.fn.expand("$HOME/")
vim.g.ruby_host_prog = home .. ".rbenv/shims/ruby"
vim.g.python3_host_prog = home .. ".pyenv/shims/python"
vim.g.ruby_path = home .. ".rbenv/shims/ruby"
vim.g["denops#deno"] = home .. ".deno/bin/deno"
