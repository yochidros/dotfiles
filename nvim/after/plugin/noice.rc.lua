local status, noice = pcall(require, 'noice')
if (not status) then return end

noice.setup({
  hacks = {
    skip_duplicate_message = true
  },
  messages = {
    enabled = false,
  }
})
