return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          {
            "gd",
            function()
              require("telescope.builtin").lsp_references({ show_line = false })
            end,
          },
        },
      },
      flow = {
        enabled = true,
        cmd = {
          "npx",
          "flow",
          "lsp",
          "--flowconfig-name",
          "scripts/flow/custom/.flowconfig",
        },
      },
    },
    setup = {
      flow = function()
        Snacks.util.lsp.on(function(_, client)
          local is_react = vim.fn.getcwd() == "/Users/nate/rhombus/react"
          if is_react and client.name == "typescript-tools" then
            client:stop(true)
          elseif not is_react and client.name == "flow" then
            client:stop(true)
          end
        end)
      end,
    },
  },
}
