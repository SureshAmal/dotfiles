return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          settings = {
            exportPdf = "onSave",
            outputPath = "$root/target/$dir/$name",
          },
        },
      },
    },
  },
}
