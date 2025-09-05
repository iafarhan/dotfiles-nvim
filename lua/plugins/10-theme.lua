-- ~/.config/nvim/lua/plugins/10-theme.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        bufferline = true, -- important
        which_key = true,
        gitsigns = true,
        treesitter = true,
        telescope = true,
        noice = true,
        mini = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
