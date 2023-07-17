return {
  "iamcco/markdown-preview.nvim",
  event = "VeryLazy",
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    { "<leader>mv", "<cmd>MarkdownPreview<cr>", mode = { "n", "x", "o" }, desc = "Markdown preview" },
    { "<leader>mc", "<cmd>MarkdownPreviewStop<cr>", mode = { "n", "x", "o" }, desc = "Markdown preview stop" },
    { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", mode = { "n", "x", "o" }, desc = "Markdown preview toggle" },
  },
}
