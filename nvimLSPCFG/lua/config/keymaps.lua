local keymaps = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymaps.set("n", "+", "<C-a>")
keymaps.set("n", "-", "<C-x>")

-- Delete a word backwards
--keymaps.set("n", "dw", "vb_d")

-- Select all
keymaps.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymaps.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymaps.set("n", "te", ":tabedit", opts)

-- Move Window
keymaps.set("n", "<c-k>", ":wincmd k<CR>")
keymaps.set("n", "<c-j>", ":wincmd j<CR>")
keymaps.set("n", "<c-h>", ":wincmd h<CR>")
keymaps.set("n", "<c-l>", ":wincmd l<CR>")
