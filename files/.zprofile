# start docker (see .aliases on how to run bitnami webapps)
alias b2d='export DOCKER_HOST=`boot2docker up 2>&1 | grep export.DOCKER_HOST|sed '\''s,^.*=,,'\''` ; echo -n '\''Docker is '\'' ; boot2docker status ; echo '\''grep -qs /Users /proc/mounts || (sudo mkdir -p /Users ; sudo mount.nfs 192.168.59.3:/Users /Users -o nolock)'\'' | boot2docker ssh sh'
# export PATH="/usr/local/bin:$PATH:~/Bitnami/arc/arcanist/bin:$HOME/.rbenv/bin:$PATH"
export EDITOR="vim"
