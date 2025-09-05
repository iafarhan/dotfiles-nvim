
# Neovim Config

This is my personal **Neovim setup**, optimized for **Go** and **Python** development.  
It’s based on [LazyVim](https://github.com/LazyVim/LazyVim) with LSP, DAP, testing, and modern navigation tools.

---

## Features
- **Language Support**
  - Go: gopls, gofumpt, goimports, Delve (dap-go, neotest-go)
  - Python: pyright/basedpyright, Ruff, Black, debugpy (dap-python, neotest-python)

- **Editing & Navigation**
  - Fuzzy finder (files, symbols, live grep)
  - File explorer (Neo-tree)
  - Symbols outline (Aerial)
  - Flash jump & Harpoon for quick movement

- **Debugging & Testing**
  - nvim-dap + dap-ui
  - Neotest integration for Go and Python

---

## Install
Clone into your Neovim config directory:

```bash
git clone https://github.com/iafarhan/dotfiles-nvim.git ~/.config/nvim
nvim
