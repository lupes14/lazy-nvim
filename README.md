# NVIM Workstation Configuration

This repository stores a custom tailored NVIM environment used for development. 

## Table of Contents:
- [Getting Started](#getting-started)
- [Tips](#tips)
- [Features](#features)
- [Feature Dependencies](#feature-dependencies)

&nbsp;


# Getting Started

## Directory Structure
```
├── README.md
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── ${PLUGIN CONFIGS}
    │   ├── vim
    │   │   ├── keymaps.lua
    │   │   └── settings.lua
    └── plugins
        ├── ${PLUGIN DECLARATIONS}
```

## Installation

1) Make a `.config` directory with a `nvim` directory inside it

```
cd ~
mkdir .config/nvim
```

2) Clone the GitHub repository

```
git clone git@github.com:lupes14/nvim-setup.git
```

3) Navigate into the repo, and copy contents into the `.config/nvim` directory. Do not copy over the `.git` directory or other GitHub related files. The command below should handle that for you.

```
cd ${REPO BASE PATH}
find . -name ".git" -prune -o -print | cpio -pdm ~/.config/nvim
```

4) Open VIM and Lazy should automatically install. Lazy is the package manager being used to install plugins. Lazy will automatically install the plugins as long as there are no breaking config changes.

&nbsp;


# Tips

- To configure lazy loading settings, update plugin declarations in `lua/plugins/${PLUGIN DECLARATION}`.
    - An example of lazy loading can be found here [plenary.lua](./lua/plugins/plenary.lua)
- [keymaps.lua](./lua/config/vim/keymaps.lua) utilizes snacks keymaps, your own custom keymaps, and which-key configurations for keymap descriptions etc.
- [settings.lua](./lua/config/vim/settings.lua) configures VIM settings such as highlight groups and other options typically set by vimscript.

&nbsp;


# Features
- Configures lazy to automatically install and manage plugins
    - For more details check out: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Configures NVIM snacks plugin to provide:
    - NVIM custom dashboard
    - Custom VIM keymaps
    - Custom pickers to enable fuzzy finders, grep, and a file explorer
    - Custom notifications
    - Custom indentation with dynamic indent highlighting
    - For more details check out: [snacks.nvim](https://github.com/folke/snacks.nvim)
- Configures mason to handle installation and configuration of LSP servers
    - For more details check out: [mason.nvim](https://github.com/williamboman/mason.nvim)
- Configures auto-completion within files
    - For more details check out: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Configures LSP server integrations
    - For more details check out: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- Configures LSP specific parsing and syntax highlighting
    - For more details check out: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Configures a floating terminal toggle similarly to VSCode's integrated terminal
    - For more details check out: [vim-floaterm](https://github.com/voldikss/vim-floaterm)
- Configures nvim-dap for debugging
    - Currently only python debugging is configured.
    - The python debugger has dependencies required to be installed.
    - See [Feature Dependencies](#feature-dependencies).
- Configures lualine to replace the default NVIM staus-line
    - For more details check out: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- Configures the status bar to show modifications of git files
    - For more details check out: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- Configures custom command line and notification window UIs
    - For more details check out: [nvim.noice](https://github.com/folke/noice.nvim)
- Configures keymaps to enable commenting out lines/blocks of code
    - For more details check out: [tcomment_vim](https://github.com/tomtom/tcomment_vim)
- Configures NVIM to have the cursor remember the last place you were in a file
    - For more details check out: [vim-lastplace](https://github.com/farmergreg/vim-lastplace)
- Configures NVIM to have a floating pop up window to show your key maps
    - For more details check out: [which-key.nvim](https://github.com/folke/which-key.nvim)
- Configures a custom theme based off the nigh-owl VSCode theme
    - For more details check out: [nigh-owl.vim](https://github.com/haishanh/night-owl.vim)
- Configures NVIM helper functions for plugins to leverage
    - For more details check out: [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- Configures NVIM game to practice VIM movement and command motion combinations
    - For more details check out: [vim-be-good](https://github.com/ThePrimeagen/vim-be-good)

&nbsp;


# Feature Dependencies
1) The `nvim-dap` plugin requires `debugpy` to be installed. You can install this globally, but that may mess with pip packages since we have to install with pip.

It is recommended to install `debugpy` into a virtual environment set at your user's path, and reference this venv in your `nvim-dap` config. This way the `debugpy` package is not installed globally but can still be used by NVIM.

If you are on a Mac and you may already have a `.venv` at your user's path depending how you install python, so you may have to skip the first command below:
```
python3 -m venv ~/.venv/debugpy
source ~/.venv/debugpy/bin/activate
pip3 install debugpy
```

Then inside the `config/nvim-dap.lua` you need to specifiy the path to the venv storing debugpy.
