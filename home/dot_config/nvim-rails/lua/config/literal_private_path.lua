local home = vim.fn.expand("$HOME/")
vim.g.ruby_host_prog = home .. ".local/share/mise/installs/ruby/latest/bin/ruby"
vim.g.python3_host_prog = home .. ".local/share/mise/installs/python/latest/bin/python"
vim.g.ruby_path = home .. ".local/share/mise/installs/ruby/latest/bin/ruby"
vim.g["denops#deno"] = "/opt/homebrew/bin/deno"
