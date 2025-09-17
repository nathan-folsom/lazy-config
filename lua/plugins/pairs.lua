return {
  {
    "nvim-mini/mini.pairs",
    opts = {
      mappings = {
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\<&].", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", register = { cr = true } },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "%w.", register = { cr = false } },
        [">"] = { action = "close", pair = "<>", register = { cr = false } },
      },
    },
  },
}
