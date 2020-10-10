# History settings
HISTSIZE=100
SAVEHIST=100

function appendPath {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

case $(uname -n) in
	macOS|Andrews-iMac.local)	
	appendPath "/usr/local/bin:/usr/local/sbin"
	appendPath "/usr/local/opt/coreutils/libexec/gnubin"
	appendPath "/usr/local/opt/findutils/libexec/gnubin"
	appendPath "/bin"
	appendPath "/usr/local/opt/openjdk/bin"
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  
	[ -f ~/bin/.fzf.zsh ] && source ~/bin/.fzf.zsh
		;;
esac

setopt prompt_subst
PROMPT='%F{red}%B%n%b%f@[%F{yellow}%B%1~%b%f]%# '

config_files=($HOME/zsh/*.zsh)

for file in ${config_files}
do
    source $file
done

autoload -Uz compinit 
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Git prompt
source $HOME/zsh/git-prompt.sh
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_

zstyle ':vcs_info:git:*' formats '%b'

# Lazy-load NVM
# Band-aid solution to NVM taking a long time to load
# See https://github.com/nvm-sh/nvm/issues/1277
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" #
# add our default nvm node (`nvm alias default 10.16.0`) to path without loading nvm
# this depends on the de fault alias being set
export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"

if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Initialise rbenv
# eval "$(rbenv init -)"

# FZF-mark
source $HOME/bin/fzf-mark/fzf-marks.plugin.zsh
