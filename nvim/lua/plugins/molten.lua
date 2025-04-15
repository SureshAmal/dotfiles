return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.molten_output_win_max_height = 9999
    vim.g.molten_auto_image_popup = false
    vim.g.molten_cover_empty_lines = false
    vim.g.molten_auto_open_output = true
    vim.g.molten_image_provider = "none"
  end,
}
