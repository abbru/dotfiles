-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--#region
local map = LazyVim.safe_keymap_set

map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
