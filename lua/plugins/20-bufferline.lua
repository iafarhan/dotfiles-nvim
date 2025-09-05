return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    opts = function(_, opts)
      opts = opts or {}
      local ok, cat = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and type(cat.get) == "function" then
        opts.highlights = cat.get()
      end
      return opts
    end,
  },
}
