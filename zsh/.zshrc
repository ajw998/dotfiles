
HISTSIZE=100
SAVEHIST=100

# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/bin:$PATH"

setopt prompt_subst
PROMPT='%F{red}%B%n%b%f@[%F{yellow}%B%1~%b%f]%# '

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && [ -f ~/bin/.fzf.zsh ] && source ~/bin/.fzf.zsh

config_files=(~/dotfiles/zsh/*.zsh)

for file in ${config_files}
do
    source $file
done

autoload -Uz compinit 
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Git prompt
source $HOME/dotfiles/zsh/git-prompt.sh

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_

zstyle ':vcs_info:git:*' formats '%b'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ "$TMUX" = '' ]; then
    tmux attach || tmux new 
fi
