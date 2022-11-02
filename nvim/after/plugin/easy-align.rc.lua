local map = vim.keymap.set
--Start interactive EasyAlign in visual mode (e.g. vipga)
map('x', 'ga', '<Plug>(EasyAlign)')

--Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('n', 'gA', '<Plug>(EasyAlign)')
