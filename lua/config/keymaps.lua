-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- other keymaps
vim.keymap.set("i", "<C-z>", "<Esc><C-z>") -- C-z in insert mode
vim.keymap.set({ "n", "i" }, "<C-a>", "<Esc>I") -- C-a for insert at the begin of line
vim.keymap.set({ "n", "i" }, "<C-e>", "<Esc>A") -- C-e for insert at the end of line
vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>GA") -- C-c for fast <Esc>
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>q<cr>") -- C-q for exit in normal/insert mode
vim.keymap.set({ "n", "i" }, "<C-x>", "<cmd>q<cr>") -- C-q for exit in normal/insert mode
