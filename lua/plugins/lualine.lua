return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    local started = false
    local function status()
      if not package.loaded["cmp"] then
        return
      end
      for _, s in ipairs(require("cmp").core.sources) do
        if s.name == "codeium" then
          if s.source:is_available() then
            started = true
          else
            return started and "error" or nil
          end
          if s.status == s.SourceStatus.FETCHING then
            return "pending"
          end
          return "ok"
        end
      end
    end

    local Util = require("lazyvim.util")
    local colors = {
      ok = Util.ui.fg("Special"),
      error = Util.ui.fg("DiagnosticError"),
      pending = Util.ui.fg("DiagnosticWarn"),
    }
    table.insert(opts.sections.lualine_x, 2, {
      function()
        return require("lazyvim.config").icons.kinds.Codeium
      end,
      cond = function()
        return status() ~= nil
      end,
      color = function()
        return colors[status()] or colors.ok
      end,
    })
  end,
}
