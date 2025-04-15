return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Custom configuration for snacks.nvim
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    image = {
      enabled = true,
      force = false,
      doc = {
        -- enable = true,
        inline = vim.g.neovim_mode == "skitty" and true or false,
        float = true,
        max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
        max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
      },
      math = {
        enabled = true,
        typst = {
          tpl = [[
        #set page(width: auto, height: auto, margin: (x: 1pt, y: 1pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        -- Custom header
        header = [[
███████╗██╗   ██╗██████╗ ███████╗███████╗██╗  ██╗
██╔════╝██║   ██║██╔══██╗██╔════╝██╔════╝██║  ██║
███████╗██║   ██║██████╔╝█████╗  ███████╗███████║
╚════██║██║   ██║██╔══██╗██╔══╝  ╚════██║██╔══██║
███████║╚██████╔╝██║  ██║███████╗███████║██║  ██║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
        ]],
        -- Custom buttons
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = "🗃️",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy Plugin Manager",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          {
            icon = "📂",
            key = "l",
            desc = "Open CodeLang Directory",
            action = ":cd /run/media/suresh/D/codelang",
          },
          { icon = "☕", key = "j", desc = "Java", action = ":cd /run/media/suresh/D/codelang/java" },
          {
            icon = "💻",
            key = "C",
            desc = "C Language",
            action = ":cd /run/media/suresh/D/codelang/c\\ language",
          },
          { icon = "🐍", key = "p", desc = "Python", action = ":cd /run/media/suresh/D/codelang/python" },
          { icon = "🦀", key = "R", desc = "Rust", action = ":cd /run/media/suresh/D/codelang/Rust" },
          { icon = " ", key = "w", desc = "Web", action = ":cd /run/media/suresh/D/codelang/Web" },
          { icon = " ", key = "T", desc = "Typst", action = ":cd /run/media/suresh/D/codelang/typst\\ files" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
