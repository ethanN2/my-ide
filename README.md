# nvim-ide-configuration

A modern Neovim IDE setup based on LazyVim.

## ⚡️ Installation

> **⚠️ Backup your current Neovim config first**
> If you already have a `~/.config/nvim` folder, move it:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

### 1. Clone this repo

```bash
git clone https://github.com/ethanN2/nvim-ide-configuration.git ~/.config/nvim
```

### 2. Open Neovim

```bash
nvim
```

> The first time you open Neovim, it will install all plugins automatically.
> Wait until it's done. Then restart Neovim.

---

## 🧠 How to Use

- `<leader>` is set to `<space>`

Here are some common keymaps:

| Action               | Keybinding   |
| -------------------- | ------------ |
| Open file finder     | `<leader>ff` |
| Toggle file explorer | `<leader>e`  |
| Open lazygit         | `<leader>g`  |
| Toggle terminal      | `<leader>tt` |
| Comment line         | `<leader>cc` |
| Save file            | `<C-s>`      |

> Use `:Lazy` to manage plugins
> Use `:Mason` to install language servers
> Use `:checkhealth` if you run into issues
