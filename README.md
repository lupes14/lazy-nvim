# NVIM Workstation Configuration

This repository stores a custom tailored NVIM environment used for development. 

&nbsp;


# Directory Structure
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

&nbsp;


# Getting Started

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
