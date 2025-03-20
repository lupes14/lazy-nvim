# NVIM Workstation Configuration

This repository stores a custom tailored NVIM environment used for development. 

&nbsp;

## Getting Started

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
