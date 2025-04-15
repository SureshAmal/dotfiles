if vim.g.neovide then
  vim.print(vim.g.neovide_version)
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  local font_size = 14
  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_image_renderer = "kitty"
  vim.g.neovide_hide_mouse_when_typing = true

  require("yazi").setup({
    image_preview = true, -- Enable image preview in Neovide
    image_renderer = "kitty", -- Set image renderer
    -- or use ImageMagick: image_renderer = "ImageMagick"
  })

  local function set_font_size(size)
    vim.opt.guifont = "JetBrainsMono Nerd Font:h" .. size
  end

  set_font_size(font_size)

  function IncreaseFontSize()
    font_size = font_size + 1
    set_font_size(font_size)
  end

  function DecreaseFontSize()
    font_size = font_size - 1
    set_font_size(font_size)
  end

  vim.api.nvim_set_keymap("n", "<C-i>", ":lua IncreaseFontSize()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua DecreaseFontSize()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>fs",
    ":lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen<CR>",
    { noremap = true, silent = true, desc = "toggle full screen" }
  )
end
