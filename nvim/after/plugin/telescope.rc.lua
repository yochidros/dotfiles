local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
-- Telescope
require("telescope").setup {
  defaults = {
    layout_config = {
      vertical = { width = 0.9 }
      -- other layout configuration here
    },
    -- other defaults configuration here
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      },
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    ["ui-select"] = {
      themes.get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { silent = true, noremap = true })
