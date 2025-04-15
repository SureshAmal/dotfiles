-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Basics
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })
vim.keymap.set("n", "==", "gg=G", { desc = "Select All" })
vim.keymap.set("n", "G", "Gzz", { desc = "last line" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "page up" })
vim.keymap.set("n", "<leader>m", "", { desc = "change directory, create files" })
vim.keymap.set("n", "<leader>h", "", { desc = "📂harpoon" })
vim.keymap.set("n", "<leader>t", "", { desc = " typst" })
vim.keymap.set("n", "<leader>t", "", { desc = " typst" })
vim.keymap.set(
  "n",
  "<leader>mC",
  "<CMD>cd /run/media/suresh/D/codelang/<CR>",
  { desc = "change to codelang directory" }
)
vim.keymap.set(
  "n",
  "<leader>mr",
  "<CMD>cd /run/media/suresh/D/codelang/Rust/<CR>",
  { desc = "change to Rust directory" }
)
vim.keymap.set(
  "n",
  "<leader>mp",
  "<CMD>cd /run/media/suresh/D/codelang/python/<CR>",
  { desc = "change to python directory" }
)
vim.keymap.set(
  "n",
  "<leader>mc",
  "<CMD>cd /run/media/suresh/D/codelang/c language/<CR>",
  { desc = "change to c language directory" }
)
vim.keymap.set(
  "n",
  "<leader>mj",
  "<CMD>cd /run/media/suresh/D/codelang/java/<CR>",
  { desc = "change to java directory" }
)
vim.keymap.set("n", "<leader>mt", "", { desc = "change to typst directory" })
vim.keymap.set(
  "n",
  "<leader>mtt",
  "<CMD>cd /run/media/suresh/D/codelang/typst files/Sem4/<CR>",
  { desc = "change to sem 4 typst" }
)
vim.keymap.set(
  "n",
  "<leader>mtp",
  "<CMD>cd /run/media/suresh/D/codelang/typst files/target/Sem4/<CR>",
  { desc = "change to sem 4 pdfs" }
)
vim.keymap.set("n", "<leader>mw", "", { desc = "change to web programs" })
vim.keymap.set(
  "n",
  "<leader>mwl",
  "<CMD>cd /run/media/suresh/D/codelang/Web/Web Learning/<CR>",
  { desc = "change to web Learning" }
)
vim.keymap.set(
  "n",
  "<leader>mwp",
  "<CMD>cd /run/media/suresh/D/codelang/Web/Web project/<CR>",
  { desc = "change to Web Project" }
)
vim.keymap.set(
  "n",
  "<leader>mwc",
  "<CMD>cd /run/media/suresh/D/codelang/Web/Web programming Sem4/<CR>",
  { desc = "change to Web Classroom" }
)
-- vim.keymap.set(
--   "n",
--   "<leader>mws",
--   "<CMD>cd /run/media/suresh/D/codelang/Web apps/s_dashboard/<CR>",
--   { desc = "change to svelte" }
-- )
-- file

local project_paths = {
  j = { path = "/run/media/suresh/D/codelang/java", ext = ".java", desc = "Java ☕" },
  C = { path = "/run/media/suresh/D/codelang/c language", ext = ".c", desc = "C 💻" },
  p = { path = "/run/media/suresh/D/codelang/python", ext = ".py", desc = "Python 🐍" },
  R = { path = "/run/media/suresh/D/codelang/Rust", ext = ".rs", desc = "Rust 🦀" },
  L = { path = "/run/media/suresh/D/codelang/Latex", ext = ".tex", desc = "LaTeX 📝" },
  T = { path = "/run/media/suresh/D/codelang/typst files", ext = ".typ", desc = "Typst ✍️" },
}

vim.keymap.set("n", "<leader>mN", function()
  -- Get the current buffer's directory
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- Determine which project the current buffer belongs to
  local selected_project = nil
  for _, project in pairs(project_paths) do
    if current_dir:find(project.path, 1, true) then
      selected_project = project
      break
    end
  end

  if selected_project then
    -- Define the prompt_for_filename function first, so it's available in scope
    local function prompt_for_filename(current_path, relative_path)
      local filename = vim.fn.input("File name (" .. selected_project.ext .. "): ", "", "file")
      if filename and filename ~= "" then
        -- If the file name does not already have the extension, append it
        if not filename:match(selected_project.ext .. "$") then
          filename = filename .. selected_project.ext
        end

        -- Construct the full path
        local full_path = current_path .. "/" .. filename

        -- Check if file already exists
        local file_exists = vim.fn.filereadable(full_path) == 1
        if file_exists then
          -- Open the existing file
          vim.cmd("edit " .. full_path)
          print("Opened file: " .. full_path)
        else
          -- Create and open the new file
          vim.cmd("edit " .. full_path)
          print("Created file: " .. full_path)
        end
      else
        print("No file name provided!")
      end
    end

    -- Now define the navigate_directories function which can use prompt_for_filename
    local function navigate_directories(current_path, relative_path)
      -- Get a list of subdirectories in the current path
      local subdirs = {}
      local handle = vim.fn.readdir(current_path, function(name)
        return vim.fn.isdirectory(current_path .. "/" .. name) == 1
      end)

      -- Add options
      table.insert(subdirs, 1, "../") -- Go back
      table.insert(subdirs, 2, "./") -- Save here

      -- Add all subdirectories
      for _, dir in ipairs(handle) do
        table.insert(subdirs, dir .. "/")
      end

      -- Show current path in the prompt
      local display_path = selected_project.path
      if relative_path ~= "" then
        display_path = display_path .. "/" .. relative_path
      end
      print("Current path: " .. display_path)

      -- Use vim.ui.select to let the user choose a directory
      vim.ui.select(subdirs, {
        prompt = "Select directory (or save here):",
        format_item = function(item)
          return item
        end,
      }, function(selected_dir)
        if selected_dir then
          if selected_dir == "./" then
            -- User wants to save in the current directory
            prompt_for_filename(current_path, relative_path)
          elseif selected_dir == "../" then
            -- Go up one level if not already at the project root
            if relative_path ~= "" then
              local parent_rel_path = vim.fn.fnamemodify(relative_path, ":h")
              if parent_rel_path == "." then
                parent_rel_path = ""
              end
              local parent_path = selected_project.path
              if parent_rel_path ~= "" then
                parent_path = parent_path .. "/" .. parent_rel_path
              end
              navigate_directories(parent_path, parent_rel_path)
            else
              -- Already at project root, just restart
              navigate_directories(selected_project.path, "")
            end
          else
            -- Navigate to the selected subdirectory
            local dir_name = selected_dir:sub(1, -2) -- Remove trailing slash
            local new_relative_path = relative_path
            if new_relative_path ~= "" then
              new_relative_path = new_relative_path .. "/"
            end
            new_relative_path = new_relative_path .. dir_name
            local new_path = current_path .. "/" .. dir_name
            navigate_directories(new_path, new_relative_path)
          end
        end
      end)
    end

    -- Start navigation from the project root
    navigate_directories(selected_project.path, "")
  else
    print("Current buffer's directory is not part of a recognized project!")
  end
end, { noremap = true, silent = true, desc = "Create or open a file by navigating through project directories" })

-- Mortel
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<leader>re", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set(
  "v",
  "<leader>m",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "evaluate visual selection" }
)
vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>A", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>a", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })
vim.keymap.set("n", "<leader>om", ":MoltenImagePopup<CR>", { silent = true, desc = "open image" })

--files
vim.keymap.set("n", "<leader>mn", function()
  local filename = vim.fn.input("New file name (no extension): ", "", "file")
  if filename and filename ~= "" then
    vim.cmd("enew") -- Create a new empty buffer
    vim.cmd("file " .. filename) -- Set the buffer name
  else
    print("No file name provided!")
  end
end, { noremap = true, silent = true, desc = "Create new file without extension" })

-- OIl.nvim
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- typst
vim.api.nvim_set_keymap(
  "n",
  "<leader>tp",
  ":TypstPreview <CR>",
  { noremap = true, silent = true, desc = "Typst preview" }
)
-- python

vim.keymap.set("n", "<C-p>", function()
  local file_path = vim.fn.expand("%:t")
  local result = vim.fn.system("python " .. file_path)
  if vim.v.shell_error ~= 0 then
    vim.notify("error occured \n" .. result)
  end
  vim.cmd("write")
end, { desc = "run python file" })

-- Snack dashboard
-- If buffer name is snack then does not open snack dashboard
local Snacks = require("snacks")

-- keybind to <leader>sz
vim.keymap.set("n", "<leader>sz", function()
  if vim.bo.filetype ~= "snacks_dashboard" then
    Snacks.dashboard()
  end
end, { desc = "Snack dashboard" })

-- avr compiling
vim.keymap.set("n", "<leader>ck", function()
  vim.cmd("write")
  vim.cmd("!make")
  vim.notify("File Saved and Compiled", vim.log.levels.INFO)
end, { desc = "AVR Compiling" })
