force_color_prompt=yes

if [ ! -n "$SSH_TTY" ] || [ ! -n "$SSH_CLIENT" ]; then
	tmux
fi

