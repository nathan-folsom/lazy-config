return {
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\<&].", register = { cr = false } },
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]. " },
        [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
      },
    },
  },
}
