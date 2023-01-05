local keymap = vim.keymap

-- window
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })
keymap.set("n", "sh", "<C-w>h", { noremap = true })
keymap.set("n", "sj", "<C-w>j", { noremap = true })
keymap.set("n", "sk", "<C-w>k", { noremap = true })
keymap.set("n", "sl", "<C-w>l", { noremap = true })

-- increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwords
keymap.set("n", "dw", 'vb"_d')

-- split window
keymap.set("n", "te", ":tabedit<CR>", { silent = true })
keymap.set("n", "ss", ":split<CR><C-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<CR><C-w>w", { silent = true })

-- noh
keymap.set("n", "no", ":noh<CR>", { silent = true })
