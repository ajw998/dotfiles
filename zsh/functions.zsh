# coloured manuals
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;40;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

mk() {
	mkdir -p "$1" && cd "$1"
}

cd() {
	builtin cd "$@" && l
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

port() {
    lsof -i -P -n | grep 'LISTEN' | fzf -m --ansi
}

# Launch simple server in Python
# Defaults to port 8000
# TODO: Check if port is available. If not, throw error
ss() {
    PORT=${1:-8000}
    PYEXEC=$(which python)
    if [ -z ${PYEXEC} ]; then
        echo "Python not found, please ensure Python is available and try again."
        exit 1
    fi

    python -m SimpleHTTPServer ${PORT}
}
