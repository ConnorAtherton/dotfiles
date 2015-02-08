# kill process
function peco-kill-process() {
    ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
}

alias kp='peco-kill-process'
