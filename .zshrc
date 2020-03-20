# History settings
HISTSIZE=100
SAVEHIST=100

case $(uname -n) in
	macOS|Andrews-iMac.local)	
	export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
	export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
	export PATH="/bin:$PATH"
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

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Initialise rbenv
eval "$(rbenv init -)"

# FZF-mark
source $HOME/bin/fzf-mark/fzf-marks.plugin.zsh
