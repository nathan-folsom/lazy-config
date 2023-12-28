return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      root_dir = require("lspconfig.util").root_pattern(".git"),
      settings = {
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
      },
    },
  },
}
