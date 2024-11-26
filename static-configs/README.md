# Static Configurations

This directory contains some files that can be statically copied somewhere to support a basic shell
with tmux and vim working properly.

---

<!--toc:start-->

- [Static Configurations](#static-configurations)
  - [Installation](#installation)
  - [Tools](#tools)
    - [Bash](#bash)
    - [Zsh](#zsh)
    - [Tmux](#tmux)
    - [Vim](#vim)
    - [Git](#git)

<!--toc:end-->

---

## Installation

Run the `install.sh` script.

## Tools

### Bash

TODO

### Zsh

TODO

### Tmux

The base configuration supports vi mode, the main keyboard shortcuts, tmux-sensible, and a popup
quake if the tmux version supports it.

To install, copy:

- `tmux.conf` to `~/.tmux.conf`
- `tmux-sensible.sh` to `~/.local/share/tmux/sensible.sh`

### Vim

The configuration is compatible with vim and neovim.

TODO

### Git

The configuration is very simple and does not use any form of commit signing.
