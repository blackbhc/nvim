return {
  "andymass/vim-matchup",
  -- Highlight, jump between pairs like if..else
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
