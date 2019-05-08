EDITOR=$(which vim)
FZF_DEFAULT_COMMAND='fd --type f'
FZF_CTRL_T_COMMAND='fd --type f'
FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi'
HISTCONTROL=ignoreboth:erasedups
HOMEBREW_INSTALL_CLEANUP=1
LANG=en_GB.UTF-8
LC_COLLATE="C"
LESS='-r --ignore-case --status-column --HILITE-UNREAD'
LESSHISTFILE=-
PAGER=less
VISUAL=code
CLICOLOR=1

export CLICOLOR FZF_DEFAULT_COMMAND FZF_CTRL_T_COMMAND PATH PAGER VISUAL HISTCONTROL HOMEBREW_INSTALL_CLEANUP LESS LESSHISTFILE LANG EDITOR LC_COLLATE

