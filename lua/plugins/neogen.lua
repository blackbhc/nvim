return {
  "danymat/neogen",
  config = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
  --     local opts = { noremap = true, silent = true }
  -- vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts),
  keys = {
    {
      "<leader>ng",
      function()
        require("neogen").generate({})
      end,
      mode = { "n" },
      desc = "Generate doxygen comment for automatic type.",
    },
    {
      "<leader>nf",
      function()
        require("neogen").generate({ type = "file" })
      end,
      mode = { "n" },
      desc = "Generate doxygen comment for a file.",
    },
    {
      "<leader>nf",
      function()
        require("neogen").generate({ type = "func" })
      end,
      mode = { "n" },
      desc = "Generate doxygen comment for a function.",
    },
    {
      "<leader>nc",
      function()
        require("neogen").generate({ type = "class" })
      end,
      mode = { "n" },
      desc = "Generate doxygen comment for a class.",
    },
  },
}
