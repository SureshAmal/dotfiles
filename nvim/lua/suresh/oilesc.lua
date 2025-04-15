vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "<ESC>", function()
      if vim.fn.win_gettype() == "popup" then
        vim.cmd("close")
      end
    end, { buffer = true, desc = "Close oil.nvim on ESC" })
  end,
})
