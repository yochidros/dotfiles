-- Syntax highlight
require 'nvim-treesitter.configs'.setup {
  indent = {
    enable = false,
    disable = {}
  },
  auto_install = true,
  highlight = {
    enable = true,
    disable = {}
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true
  }
}
