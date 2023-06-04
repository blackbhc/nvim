-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- other keymaps
vim.keymap.set("i", "<C-z>", "<Esc><C-z>") -- C-z in insert mode
vim.keymap.set({ "n", "i" }, "<C-a>", "<Esc>I") -- C-a for insert at the begin of line
vim.keymap.set({ "n", "i" }, "<C-e>", "<Esc>A") -- C-e for insert at the end of line
vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>") -- C-c for fast <Esc>
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>q<cr>") -- C-q for exit in normal/insert mode
vim.keymap.set({ "n", "i" }, "<C-x>", "<cmd>wq<cr>") -- C-x for write and exit in normal/insert mode
vim.keymap.set({ "i" }, "<A-b>", "<Esc>g e i") -- A-b for move to the previous word
vim.keymap.set({ "i", "n" }, "<A-f>", "<Esc>ea") -- A-f for move to the next word
vim.keymap.set({ "i", "n" }, "<A-d>", "<Esc>wdwi") -- A-b for move to the previous word
vim.keymap.set({ "i", "n" }, "<A-BS>", "<Esc>bdwi") -- A-f for move to the next word
