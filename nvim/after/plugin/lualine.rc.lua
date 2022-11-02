local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup({
  options = {
    icon_enabled = true,
    theme = 'auto',
    disable_filetypes = {}
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      "os.date('%H:%M:%S')",
      'filename',
      "require'lsp-status'.status()"
    }
  },
  extensions = { 'fugitive' }
})
