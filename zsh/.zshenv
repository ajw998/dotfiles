EDITOR=$(which vim)
FZF_ALT_C_COMMAND='find . -type d ! -path "./studres/*"'
FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
HISTCONTROL=ignoreboth:erasedups
HOMEBREW_INSTALL_CLEANUP=1
LANG=en_GB.UTF-8
LC_COLLATE="C"
LESS='-r --ignore-case --status-column --HILITE-UNREAD'
LESSHISTFILE=-
PAGER=less
VISUAL=code
CLICOLOR=1

export CLICOLOR PATH PAGER VISUAL HISTCONTROL HOMEBREW_INSTALL_CLEANUP LESS LESSHISTFILE LANG EDITOR FZF_DEFAULT_COMMAND LC_COLLATE FZF_ALT_C_COMMAND

