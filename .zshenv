case $(uname -n) in
	macOS|Andrews-iMac.local)
		EDITOR=$(which nvim)
		FZF_DEFAULT_COMMAND='fd --type f --hidden' 
		FZF_CTRL_T_COMMAND='fd --type f --hidden'
		FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi'
		HISTCONTROL=ignoreboth:erasedups
		HOMEBREW_INSTALL_CLEANUP=1
		HTTPIE_CONFIG_DIR='$HOME/.config/httpie'
		LANG=en_GB.UTF-8
		LC_COLLATE="C"
		LESS='-r --ignore-case --status-column --HILITE-UNREAD'
		LESSHISTFILE=-
		PAGER=less
		VISUAL=nvim
		CLICOLOR=1
		export CLICOLOR FZF_DEFAULT_COMMAND FZF_CTRL_T_COMMAND FZF_DEFAULT_OPTS PAGER VISUAL HISTCONTROL HOMEBREW_INSTALL_CLEANUP HTTPIE_CONFIG_DIR LESS LESSHISTFILE LANG EDITOR LC_COLLATE 
		;;
esac
