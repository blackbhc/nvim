return {
  "iamcco/markdown-preview.nvim",
  event = "VeryLazy",
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = { { "<leader>mv", "<cmd>MarkdownPreview<cr>" }, { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>" } },
}
