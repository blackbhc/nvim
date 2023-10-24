return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
    local ft = require("Comment.ft")
    -- 1. Using set function
    ft
      -- Set only line comment
      .set("yaml", "#%s")
      -- Or set both line and block commentstring
      .set("javascript", { "//%s", "/*%s*/" })
    -- 2. Metatable magic
    ft.cpp = { "//%s", "/*\n%s\n*/" }
    ft.ini = "#%s"
  end,
  event = "VeryLazy",
}
