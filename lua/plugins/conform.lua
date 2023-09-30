return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  init = function()
    -- Install the conform formatter on VeryLazy
    require("lazyvim.util").on_very_lazy(function()
      require("lazyvim.plugins.lsp.format").custom_format = function(buf)
        return require("conform").format({ bufnr = buf })
      end
    end)
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      python = { "black" },
      ["html"] = { { "prettierd", "prettier" } },
      ["json"] = { { "prettierd", "prettier" } },
      ["jsonc"] = { { "prettierd", "prettier" } },
      ["toml"] = { { "prettierd", "prettier" } },
      ["yaml"] = { { "prettierd", "prettier" } },
      ["markdown"] = { { "prettierd", "prettier" } },
    },
    -- LazyVim will merge the options you set here with builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string,table>
    formatters = {
      -- -- Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    opts.formatters = opts.formatters or {}
    for f, o in pairs(opts.formatters) do
      local ok, formatter = pcall(require, "conform.formatters." .. f)
      opts.formatters[f] = vim.tbl_deep_extend("force", {}, ok and formatter or {}, o)
    end
    require("conform").setup(opts)
  end,
}
