return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          {
            "gr",
            function()
              require("telescope.builtin").lsp_references({ show_line = false })
            end,
          },
        },
      },
      flow = { enabled = true },
    },
  },
}
