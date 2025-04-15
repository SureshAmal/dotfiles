--  vim.api.nvim_create_augroup("CompileTypstOnSave", { clear = true })
--
--vim.api.nvim_create_autocmd("BufWritePost", {
--group = "CompileTypstOnSave",
--pattern = "*.typ",
--callback = function()
--  local file_path = vim.fn.expand("%:p") -- Full path of the current buffer file
--  local file_name = vim.fn.expand("%:p:r") -- File name without extension
--  local output_file = file_name .. ".pdf"
--
--  local compile_command = 'typst compile "' .. file_path .. '" "' .. output_file .. '"'
--  print(compile_command)
--  local result = vim.fn.system(compile_command)
--  if vim.v.shell_error ~= 0 then
--    vim.notify("command :" .. compile_command .. "\n Failed to compile Typst file:\n" .. result, vim.log.levels.ERROR)
--  else
--    vim.notify("Typst file compiled successfully: " .. output_file, vim.log.levels.INFO)
--  end
--  vim.cmd("write")
-- end,
-- })
--
vim.keymap.set("n", "<leader>tc", function()
  local file_path = vim.fn.expand("%:p") -- Full path of the current buffer file
  local file_name = vim.fn.expand("%:p:r") -- File name without extension
  local output_file = file_name .. ".pdf"
  local compile_command = 'typst compile "' .. file_path .. '" "' .. output_file .. '"'
  local result = vim.fn.system(compile_command)
  if vim.v.shell_error ~= 0 then
    vim.notify("command :" .. compile_command .. "\n Failed to compile Typst file:\n" .. result, vim.log.levels.ERROR)
  else
    vim.notify("Typst file compiled successfully: " .. output_file, vim.log.levels.INFO)
  end
  vim.cmd("write")
end, { desc = "typst compile" })
