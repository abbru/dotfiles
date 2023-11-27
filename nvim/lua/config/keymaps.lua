-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
keymaps.set("n", "<tab>", ":BufferLineCycleNext<CR>", opts)
keymaps.set("n", "<S-tab>", ":BufferLineCyclePrev<CR>", opts)

-- Split Window
keymaps.set("n", "ss", ":split<Return>", opts)
keymaps.set("n", "sv", ":vsplit<Return>", opts)

-- Move Window
keymaps.set("n", "sh", "<C-w>h")
keymaps.set("n", "sk", "<C-w>k")
keymaps.set("n", "sj", "<C-w>j")
keymaps.set("n", "sl", "<C-w>l")

-- Resize Window
keymaps.set("n", "<C-w>left", "<C-w><")
keymaps.set("n", "<C-w>right", "<C-w>>")
keymaps.set("n", "<C-w>up", "<C-w>+")
keymaps.set("n", "<C-w>down", "<C-w>-")

-- Diagnostic
keymaps.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
