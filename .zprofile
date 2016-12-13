# configure XDEBUG support
# export XDEBUG_CONFIG="idekey=XDEBUG";

export GOPATH="/Users/dsiebel/Development/Go"

# set PATH so it includes user's private bin if it exists
PATH="/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH"

# use vim as default editor for everything
export EDITOR="/usr/bin/vim"
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR

# export DOCKER_TLS_VERIFY="1"
# export DOCKER_HOST="tcp://192.168.99.100:2376"
# export DOCKER_CERT_PATH="/Users/dsiebel/.docker/machine/machines/default"
# export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell:
# # eval $(docker-machine env default)

# setup java 1.8 properly. Thanks, Steve!
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
