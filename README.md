# Dotfiles

Personal dotfiles for macOS

## Dependencies

The only dependency you need is `git`.

Please ensure you have installed Xcode CLI tools before continuing. You may do
so using this command: `xcode-select --install`.

## Setup 

The command belows uses `config` as a custom alias to configure dotfiles. You
may, however, use any alias you like.

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config remote add origin git@github.com:ajw998/dotfiles.git
config checkout
```

Ensure that you hide files that you are not explicitly tracking with the
following:

```bash
config config --local status.showUntrackedFiles no
```

To track a new file, run `config` like any other `git` commands:

```bash
config status
config add .gitignore
config commit -m "Add .gitignore"
config push
```

## Settings and Configurations

This dotfile repository provides customisation for the following: 

* `bash`
* `curl`
* `fd`
* `git`
* `macOS`
* `neovim`
* `ripgrep`
* `tmux`
* `vim`
* `code` 
* `zsh`

## LICENSE

[WTFPL](http://www.wtfpl.net/)
