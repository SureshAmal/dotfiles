-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
vim.cmd("colorscheme tokyonight-moon")

require("suresh.neovide")
require("suresh.togglebg")
require("suresh.oilesc")
require("suresh.typstcompile")

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- Create the toggle function
_G.toggle_snacks_image = function(enable)
  -- Get the Snacks module
  local Snacks = require("snacks")

  if Snacks.image then
    -- Set enabled state using the correct commands
    Snacks.image.config.enabled = enable
    Snacks.image.config.math.enabled = enable
    Snacks.image.config.doc.enabled = enable

    -- Notify user
    vim.notify("Snacks image support " .. (enable and "enabled" or "disabled"), vim.log.levels.INFO)
  else
    vim.notify("Snacks image module not available", vim.log.levels.ERROR)
  end
end

-- Add keymapping for toggling
vim.keymap.set("n", "<leader>s.", function()
  local Snacks = require("snacks")
  local current = Snacks.image and Snacks.image.config.enabled
  _G.toggle_snacks_image(not current)
end, { desc = "Toggle Snacks image support" })

-- Usage examples:
-- To enable: configure_snacks_image(true)
-- To disable: configure_snacks_image(false)
-- becon ls
-- vim.g.lazyvim_rust_diagnostics = "bacon-ls"
