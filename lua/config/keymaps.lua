-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- other keymaps
vim.keymap.set("i", "<C-z>", "<Esc><C-z>") -- C-z in insert mode
vim.keymap.set({ "n", "i" }, "<C-a>", "<Esc>I") -- C-a for insert at the begin of line
vim.keymap.set({ "n", "i" }, "<C-e>", "<Esc>A") -- C-e for insert at the end of line
vim.keymap.set({ "n", "i" }, "<C-x>", "<Esc>ggI") -- C-x for insert at the begin of the file
vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>GA") -- C-c for insert at the end of the file
vim.keymap.set({ "o", "i" }, "<C-o>", "<Esc>o") -- C-o for insert a new line in insert/normal mode
vim.keymap.set({ "i" }, "<C-h>", "<cmd>noh<cr>i") -- C-h to toggle hight in insert mode
vim.keymap.set({ "n" }, "<C-h>", "<cmd>noh<cr>") -- C-h for toggle hight in normal mode
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<cr>") -- C-s for save in normal/insert mode
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>q<cr>") -- C-q for exit in normal/insert mode
vim.keymap.set({ "n", "i" }, "<A-q>", "<cmd>q<cr>") -- A-q for exit in normal/insert mode
