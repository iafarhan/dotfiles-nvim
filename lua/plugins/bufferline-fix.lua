return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin/nvim" },
    opts = function(_, opts)
      local ok, cat = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and type(cat.get) == "function" then
        opts = opts or {}
        opts.highlights = cat.get()
      end
      return opts
    end,
  },
}
