return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = {
      "gr",
      function()
        require("telescope.builtin").lsp_references({ show_line = false })
      end,
    }
  end,
}
