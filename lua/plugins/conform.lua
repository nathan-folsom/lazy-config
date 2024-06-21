return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        rustdx = {
          command = "dx",
          args = { "fmt", "-f", "$FILENAME" },
          stdin = false,
        },
      },
      formatters_by_ft = {
        rust = { "rustfmt", "rustdx" },
      },
    },
  },
}
