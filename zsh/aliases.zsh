alias -g latest='*(om[1])'
alias :q='exit'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias doom='$HOME/.emacs.d/bin/doom'
alias grep='grep --color=always'
alias l='exa -lah'
alias mp='mpc toggle'
alias o='open .'
alias rf='source $HOME/.zshrc'
alias tmux='tmux -2'
alias update='sudo softwareupdate -i -a; brew upgrade; brew update; brew cleanup; brew cask upgrade; npm install npm -g; npm update -g; nvim +PlugUpdate +qall'
# All vi-related stuff should map to neovim
# Apart from vi (this is the fallback)
alias v='nvim'
alias vim='nvim'
# Always run emacs in the background
alias emacs='emacs &'
