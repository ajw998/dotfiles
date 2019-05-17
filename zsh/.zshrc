HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

# PROMPT='%F{red}%B%n%b%f@[%F{yellow}%B%1~%b%f]%# '
setopt prompt_subst

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
    [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
      ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
      local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

      local AHEAD="%F{red}⇡NUM%f"
      local BEHIND="%F{cya}⇣NUM%f"
      local MERGING="%F{magenta}⚡︎%f"
      local UNTRACKED="%F{red}●%f"
      local MODIFIED="%F{yellow}●%f"
      local STAGED="%F{green}●%f"

      local -a DIVERGENCES
      local -a FLAGS

      local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
      if [ "$NUM_AHEAD" -gt 0 ]; then
          DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
      fi

      local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
      if [ "$NUM_BEHIND" -gt 0 ]; then
          DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
      fi

      local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
      if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
          FLAGS+=( "$MERGING" )
      fi

      if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
          FLAGS+=( "$UNTRACKED" )
      fi

      if ! git diff --quiet 2> /dev/null; then
          FLAGS+=( "$MODIFIED" )
      fi

      if ! git diff --cached --quiet 2> /dev/null; then
          FLAGS+=( "$STAGED" )
      fi

      local -a GIT_INFO
      GIT_INFO+=( "\e[0;37m±" )
      [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
      [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
      [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
      GIT_INFO+=( "\e[0;37m$GIT_LOCATION%f" )
      echo "${(j: :)GIT_INFO}"

  }

PS1="$(ssh_info)%F{magenta}%~%u%f $(git_info) %(?.%F{blue}.%F{red})%(!.#.❯)%f "

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && [ -f ~/bin/.fzf.zsh ] && source ~/bin/.fzf.zsh

config_files=(~/dotfiles/zsh/*.zsh)

for file in ${config_files}
do
    source $file
done

autoload -Uz compinit 
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
fpath=(/usr/local/share/zsh-completions $fpath)

# Git prompt
# source $HOME/dotfiles/zsh/git-prompt.sh

# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# RPROMPT=\$vcs_info_msg_0_

# PROMPT=\$vcs_info_msg_0_'%# '

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

if [ "$TERM" = 'screen-256color' ] && [ -n "$TMUX" ]; then
    conda deactivate
    conda activate base
fi
