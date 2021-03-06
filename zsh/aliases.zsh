alias -g latest='*(om[1])'
alias :q='exit'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cleanup='[ -f "$HOME/.cleanup_list" ] && < .cleanup_list tr "\n" "\n" | xargs -L1 rm -rf || exit 0'
alias grep='grep --color=always'
alias l='exa -lah'
alias mp='mpc toggle'
alias o='open .'
alias rf='source $HOME/.zshrc'
alias tmux='tmux -2'
alias update='sudo softwareupdate -i -a; brew upgrade; brew update; brew cleanup; brew upgrade --cask; npm install npm -g; npm update -g; nvim +PlugUpdate +qall'
alias delhist='find . -name "*history" -maxdepth 1 -print0 | xargs -0 /bin/rm -v'
# All vi-related stuff should map to neovim
# Apart from vi (this is the fallback)
alias v='nvim'
alias vim='nvim'
alias nvm='unalias nvm; [ -s /usr/local/opt/nvm/nvm.sh ] && . "/usr/local/opt/nvm/nvm.sh"; nvm $@'
alias sbcl='rlwrap sbcl'
alias hstat="curl -o /dev/null --silent --head --write-out '%{http_code}\n' $1"
