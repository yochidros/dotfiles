require('bufferline').setup {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = { 'javascript' },
  exclude_name = { 'package.json' },

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

local keymap = vim.keymap
local bufferline_opts = { noremap = true, silent = true }

keymap.set('n', '<M-,>', '<Cmd>BufferPrevious<CR>', bufferline_opts)
keymap.set('n', '<M-.>', '<Cmd>BufferNext<CR>', bufferline_opts)
-- Re-order to previous/next
keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', bufferline_opts)
keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', bufferline_opts)
-- Goto buffer in position...
keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', bufferline_opts)
keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', bufferline_opts)
keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', bufferline_opts)
keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', bufferline_opts)
keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', bufferline_opts)
keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', bufferline_opts)
keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', bufferline_opts)
keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', bufferline_opts)
keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', bufferline_opts)
keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', bufferline_opts)
-- Close buffer
keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', bufferline_opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
keymap.set('n', '<C-A-p>', '<Cmd>BufferPick<CR>', bufferline_opts)
-- Sort automatically by...
keymap.set('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', bufferline_opts)
keymap.set('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', bufferline_opts)
keymap.set('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', bufferline_opts)
keymap.set('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', bufferline_opts)
