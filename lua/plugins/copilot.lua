return {
  -- Core Copilot client (Node >= 20)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      panel = { enabled = true },
      suggestion = { enabled = true, auto_trigger = true, debounce = 75 },
      filetypes = { markdown = true, gitcommit = true },
    },
  },
}
