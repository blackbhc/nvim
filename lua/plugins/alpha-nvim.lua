return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo =
      [[NNNNNNNN        NNNNNNNN                               VVVVVVVV           VVVVVVVViiii                         
N:::::::N       N::::::N                               V::::::V           V::::::i::::i                        
N::::::::N      N::::::N                               V::::::V           V::::::Viiii                         
N:::::::::N     N::::::N                               V::::::V           V::::::V                             
N::::::::::N    N::::::N   eeeeeeeeeeee      oooooooooooV:::::V           V:::::iiiiiii   mmmmmmm    mmmmmmm   
N:::::::::::N   N::::::N ee::::::::::::ee  oo:::::::::::oV:::::V         V:::::Vi:::::i mm:::::::m  m:::::::mm 
N:::::::N::::N  N::::::Ne::::::eeeee:::::eo:::::::::::::::V:::::V       V:::::V  i::::im::::::::::mm::::::::::m
N::::::N N::::N N::::::e::::::e     e:::::o:::::ooooo:::::oV:::::V     V:::::V   i::::im::::::::::::::::::::::m
N::::::N  N::::N:::::::e:::::::eeeee::::::o::::o     o::::o V:::::V   V:::::V    i::::im:::::mmm::::::mmm:::::m
N::::::N   N:::::::::::e:::::::::::::::::eo::::o     o::::o  V:::::V V:::::V     i::::im::::m   m::::m   m::::m
N::::::N    N::::::::::e::::::eeeeeeeeeee o::::o     o::::o   V:::::V:::::V      i::::im::::m   m::::m   m::::m
N::::::N     N:::::::::e:::::::e          o::::o     o::::o    V:::::::::V       i::::im::::m   m::::m   m::::m
N::::::N      N::::::::e::::::::e         o:::::ooooo:::::o     V:::::::V       i::::::m::::m   m::::m   m::::m
N::::::N       N:::::::Ne::::::::eeeeeeee o:::::::::::::::o      V:::::V        i::::::m::::m   m::::m   m::::m
N::::::N        N::::::N ee:::::::::::::e  oo:::::::::::oo        V:::V         i::::::m::::m   m::::m   m::::m
NNNNNNNN         NNNNNNN   eeeeeeeeeeeeee    ooooooooooo           VVV          iiiiiiimmmmmm   mmmmmm   mmmmmm]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰛔 " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
