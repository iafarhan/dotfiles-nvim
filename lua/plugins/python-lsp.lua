return {
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.g.lazyvim_python_lsp = "pyright"
      vim.g.lazyvim_python_ruff = "ruff"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = { init_options = { settings = { logLevel = "error", lineLength = 100 } } },
      },
      setup = {
        ruff = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            client.server_capabilities.hoverProvider = false
          end, "ruff")
        end,
      },
    },
  },
}
