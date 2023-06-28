-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.o.termguicolors = true
vim.g.copilot_filetypes = { markdown = true }
-- enable copilot for markdown files
vim.cmd("source $HOME/.config/nvim/vimrc.vim")
