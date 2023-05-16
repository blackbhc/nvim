-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- other keymaps
vim.keymap.set("i", "<C-z>", "<Esc><C-z>") -- C-z in insert mode
vim.keymap.set({ "n", "i" }, "<C-a>", "<Esc>I") -- C-a for insert at the begin
vim.keymap.set({ "n", "i" }, "<C-e>", "<Esc>A") -- C-e for insert at the end
vim.keymap.set({ "o", "i" }, "<C-o>", "<Esc>o") -- C-o for insert a new line in insert/normal mode
vim.keymap.set({ "i" }, "<C-h>", "<cmd>noh<cr>i") -- C-h to toggle hight in insert mode
vim.keymap.set({ "n" }, "<C-h>", "<cmd>noh<cr>") -- C-h for toggle hight in normal mode
