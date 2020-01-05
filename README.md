# Dotfiles

Personal dotfiles for macOS

## Dependencies

* `git`

## Setup 

The command belows uses `config` as a custom alias to configure dotfiles. You
may, however, use any alias you like.

```bash
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config remote add origin git@github.com:ajw998/dotfiles.git
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
## Updating subtree repository from upstream

## Settings and Configurations

## LICENSE

GPL
