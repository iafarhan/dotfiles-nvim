return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,

    init = function()
      local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and mod and mod.get_theme and not mod.get then
        mod.get = mod.get_theme
      end
    end,
    opts = { flavour = "mocha", integrations = { notify = true, which_key = true } },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = { default_direction = "right", min_width = 28 },
      filter_kind = false,
      attach_mode = "global",
      nerd_font = "auto",
      icons = {},
    },
    keys = {
      { "<leader>so", "<cmd>AerialToggle!<cr>", desc = "Symbols Outline" },
      {
        "]s",
        function()
          require("aerial").next()
        end,
        desc = "Next Symbol",
      },
      {
        "[s",
        function()
          require("aerial").prev()
        end,
        desc = "Prev Symbol",
      },
    },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
    keys = {

      {
        "<leader><leader>",
        function()
          require("snacks").picker.files({ hidden = true, ignored = true })
        end,
        desc = "Find Files and hidden",
      },

      {
        "<leader>ss",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "Search Symbols (file)",
      },
      {
        "<leader>sS",
        function()
          require("snacks").picker.lsp_workspace_symbols()
        end,
        desc = "Search Symbols (workspace)",
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and mod then
          local fn = mod.get_theme or mod.get
          if type(fn) == "function" then
            opts.highlights = fn()
          end
        end
      end
    end,
  },

  { "folke/flash.nvim", opts = {} },
  { "ThePrimeagen/harpoon", branch = "harpoon2", opts = {} },
  { "nvim-pack/nvim-spectre", dependencies = { "nvim-lua/plenary.nvim" } },

  { "folke/trouble.nvim", opts = {} },

  { "lewis6991/gitsigns.nvim", opts = { current_line_blame = true } },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_, opts)
      local dapui = require("dapui")
      dapui.setup(opts or {})
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  { "leoluz/nvim-dap-go", ft = "go", dependencies = { "mfussenegger/nvim-dap" }, opts = {} },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local python
      local ok, mason_registry = pcall(require, "mason-registry")
      if ok then
        local ok_pkg, pkg = pcall(mason_registry.get_package, "debugpy")
        if ok_pkg and pkg:is_installed() then
          local path = pkg:get_install_path()
          if vim.loop.os_uname().sysname:match("Windows") then
            python = path .. "\\venv\\Scripts\\python.exe"
          else
            python = path .. "/venv/bin/python"
          end
          if vim.fn.executable(python) ~= 1 then
            python = nil
          end
        end
      end
      require("dap-python").setup(python or "python")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
    },
  },

  {
    "neovim/nvim-lspconfig",

    keys = { { "gr", false, mode = "n" } },
    opts = {
      servers = {

        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              analyses = { unusedparams = true, unusedwrite = true, nilness = true },
              codelenses = { test = true, tidy = true, upgrade_dependency = true },
              hints = { assignVariableTypes = true, parameterNames = true, rangeVariableTypes = true },
              completeUnimported = true,
              staticcheck = true,
            },
          },
        },
        pyright = {},
        ruff = {
          init_options = {
            settings = {
              logLevel = "error",
              lineLength = 100,
            },
          },
        },
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

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "python",
        "lua",
        "bash",
        "json",
        "yaml",
        "toml",
        "regex",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
        ["neotest-golang"] = {
          dap_go_enabled = true,
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts or {})
      wk.add({
        { "<leader>h", group = "harpoon" },
        { "<leader>r", group = "replace" },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    init = function()
      pcall(vim.keymap.del, "n", "gr")
    end,
    opts = {
      keys = {
        {
          "s",
          function()
            require("flash").jump()
          end,
          mode = { "n", "x", "o" },
          desc = "Flash Jump",
        },
        {
          "S",
          function()
            require("flash").treesitter()
          end,
          mode = { "n", "x", "o" },
          desc = "Flash TS",
        },

        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon Add",
        },
        {
          "<leader>hh",
          function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
          end,
          desc = "Harpoon Menu",
        },
        {
          "<leader>h1",
          function()
            require("harpoon"):list():select(1)
          end,
          desc = "Harpoon 1",
        },
        {
          "<leader>h2",
          function()
            require("harpoon"):list():select(2)
          end,
          desc = "Harpoon 2",
        },
        {
          "<leader>h3",
          function()
            require("harpoon"):list():select(3)
          end,
          desc = "Harpoon 3",
        },
        {
          "<leader>h4",
          function()
            require("harpoon"):list():select(4)
          end,
          desc = "Harpoon 4",
        },

        {
          "<leader>sr",
          function()
            require("spectre").open()
          end,
          desc = "Search/Replace (Spectre)",
        },

        {
          "<leader>dd",
          function()
            require("dap").continue()
          end,
          desc = "Debug Continue",
        },
        {
          "<leader>db",
          function()
            require("dap").toggle_breakpoint()
          end,
          desc = "Toggle Breakpoint",
        },
        {
          "<leader>du",
          function()
            require("dapui").toggle({})
          end,
          desc = "DAP UI",
        },

        {
          "<leader>tt",
          function()
            require("neotest").run.run()
          end,
          desc = "Test Nearest",
        },
        {
          "<leader>tT",
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end,
          desc = "Test File",
        },
        {
          "<leader>to",
          function()
            require("neotest").output.open({ enter = true })
          end,
          desc = "Test Output",
        },
        {
          "<leader>ts",
          function()
            require("neotest").summary.toggle()
          end,
          desc = "Test Summary",
        },

        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

        {
          "<leader>fr",
          function()
            local ok, fzf = pcall(require, "fzf-lua")
            if ok then
              fzf.lsp_references()
            else
              require("telescope.builtin").lsp_references()
            end
          end,
          desc = "Find References",
        },
      },
    },
  },
}
