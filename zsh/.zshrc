HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

PROMPT='%F{red}%B%n%b%f@%m%# '

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && [ -f ~/bin/.fzf.zsh ] && source ~/bin/.fzf.zsh

config_files=(~/dotfiles/zsh/*.zsh)

for file in ${config_files}
do
	source $file
done

autoload -U compinit 
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fpath=(/usr/local/share/zsh-completions $fpath)

# Git prompt
source $HOME/dotfiles/zsh/git-prompt.sh

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_

# PROMPT=\$vcs_info_msg_0_'%# '

zstyle ':vcs_info:git:*' formats '%b'

# iTerm2 zsh integration
test -e "${HOME}/bin/.iterm2_shell_integration.zsh" && source "${HOME}/bin/.iterm2_shell_integration.zsh"
