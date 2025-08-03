# Dotfiles

This project is a collection of personal configuration files, also known as
"dotfiles". It sets up a development environment with a consistent configuration
across different machines.

## Project Overview

The primary purpose of this project is to manage and version-control the
configuration of various development tools. The setup is automated through
a Python script that creates symlinks from this repository to the appropriate
locations in the user's home directory.

### Key Technologies & Tools

- **Editor:** [Neovim](https://neovim.io/) is the primary text editor,
  configured with Lua.
- **Shell:** The shell environment is customized using `bash`, with `starship`
  for the prompt.
- **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) is the configured
  terminal emulator.
- **macOS UI:** [Sketchybar](https://felixkratz.github.io/SketchyBar/) is used
  for a custom status bar on macOS.
- **Version Management:** `mise` is used for managing different versions of
  tools like Rust.
- **Dotfile Management:** A custom Python script in `setup/links.py` handles the
  symlinking of the configuration files.

## Getting Started

To use these dotfiles, you would typically clone this repository and then run
the setup script.

```bash
git clone <repository-url> ~/.dotfiles
python ~/.dotfiles/setup/links.py
```

This will create symlinks for all the configurations.

## Development Conventions

- **Neovim Configuration:** The Neovim setup is heavily customized using Lua.
  The main entry point is `neovim/init.vim`, which in turn loads the Lua
  configuration from `neovim/lua/main.lua`. The configuration is modular, with
  plugins, LSP, and key mappings separated into different files.
- **Shell Configuration:** The `bashrc` sources various files from the
  `bash/config` directory, organizing the shell setup by topic (e.g., `git`,
  `python`, `docker`).
- **Keybindings:** The `wezterm.lua` file contains a detailed set of keybindings
  for the WezTerm terminal, organized with a "leader" key (`CMD+w`). This suggests
  a modal, Vim-like approach to terminal navigation and management.
