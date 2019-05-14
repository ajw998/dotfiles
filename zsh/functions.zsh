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
    if [ "$uid" != "0" ]; then
        pid=$(ps -f -u $uid | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# occupied ports
op() {
    lsof -i -p -n | grep 'listen' | fzf -m --ansi
}

# Launch simple server in python
# defaults to port 8000
# todo: check if port is available. if not, throw error
    ss() {
        port=${1:-8000}
        pyexec=$(which python)
        if [ -z ${pyexec} ]; then
            echo "python not found, please ensure python is available and try again."
            exit 1
        fi

        python -m simplehttpserver ${port}
    }

# Display colour palette
# Source: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
colors() {
    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m\
        44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m';
        do FG=${FGs// /}
            echo -en " $FGs \033[$FG  $T  "
            for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
            do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
            done
            echo;
        done
        echo

    }
