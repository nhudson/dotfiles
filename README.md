![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg) 
![](https://img.shields.io/github/last-commit/nhudson/dotfiles)

# dotfiles

This is a collection of dotfiles on my laptop

## Features
- OS: [Pop OS 22.04](https://pop.system76.com/)
- model: [System76 Oryx Pro 10](https://system76.com/laptops/oryx)
- display server: [X11](https://www.x.org/wiki/)
- compositor: [picom](https://github.com/yshui/picom)
- top bar: [polybar](https://github.com/polybar/polybar)
- launcher & powermenu: [rofi](https://github.com/davatorium/rofi)
- text editor: [neovim](https://neovim.io/)
- neovim config: [LunarVim](https://github.com/nhudson/lvim)
- window manager: [bspwm](https://github.com/baskerville/bspwm)
- terminal: [kitty](https://github.com/kovidgoyal/kitty)
- shell: [zsh](https://www.zsh.org/)
- shell theme: [p10k](https://github.com/romkatv/powerlevel10k)
- pdf reader: [zathura](https://pwmt.org/projects/zathura/)
- terminal file manager: [ranger](https://github.com/ranger/ranger)

## Installation

For now I just link all of the config directories to their location, and link all scripts to their location.

```shell
$ for dir in `ls .config`
  do
    ln -s `pwd`/.config/$dir ~/.config/$dir
  done
```

```shell
ln -s `pwd`/.local/bin/laptop-power.sh ~/.local/bin/laptop-power.sh
```

```shell
ln -s `pwd`/.wallpapers ~/.wallpapers
ln -s `pwd`/.screenlayout/ ~/.screenlayout
```

## Showcase

![screenshot](/img/screenshot.png)
