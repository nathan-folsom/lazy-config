return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- layout_strategy = "vertical",
      },
    },
    keys = {
      -- Swap keymaps for file finder, I pretty much always use the cwd version
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader><leader>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },
}
