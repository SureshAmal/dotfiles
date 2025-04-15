local transparency = 0.91

vim.cmd("hi Normal guibg=NONE")
vim.cmd("hi NormalNC guibg=NONE")
vim.g.neovide_transparency = transparency
vim.g.transparent_background = true
function Toggle_transparency_and_background()
  if vim.g.transparent_background == nil or vim.g.transparent_background == false then
    vim.cmd("hi Normal guibg=NONE")
    vim.cmd("hi NormalNC guibg=NONE")
    vim.g.neovide_transparency = transparency
    vim.g.transparent_background = true
  else
    vim.cmd("hi Normal guibg=#1E1E1E")
    vim.cmd("hi NormalNC guibg=#1E1E1E")
    vim.g.neovide_transparency = 1.0
    vim.g.transparent_background = false
  end
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>z",
  ":lua Toggle_transparency_and_background()<CR>",
  { noremap = true, silent = true }
)
