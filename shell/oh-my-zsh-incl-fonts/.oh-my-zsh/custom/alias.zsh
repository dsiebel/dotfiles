alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

alias hcomposer='hhvm /usr/local/bin/composer'

alias gds='git diff --staged'
alias gbs='git branch -av'

alias hosts='sudo vim /etc/hosts; dscacheutil -flushcache'

alias use_php56="brew unlink php70 && brew link php56"
alias use_php70="brew unlink php56 && brew link php70"

# alias composer='/usr/local/bin/composer_noxdebug.sh'
# alias composer='COMPOSER_DISABLE_XDEBUG_WARN=1 /usr/local/bin/php -d xdebug.remote_enable=0 -d xdebug.profiler_enable=0 -d xdebug.default_enable=0 /usr/local/bin/composer'
alias composer='PHP_INI_SCAN_DIR=/usr/local/etc/php/composer/conf.d php -c /usr/local/etc/php/composer /usr/local/bin/composer'
alias phpd='php -dxdebug.remote_enable=1 -dxdebug.remote_mode=req -dxdebug.remote_autostart=1 -dxdebug.remote_port=9000 -dxdebug.remote_host=127.0.0.1'

# docker
alias docker-env-default='eval $(docker-machine env default)'
alias docker-cleanup="docker ps -a | grep 'weeks ago|months ago' | awk '{print $1}' | xargs docker rm"

alias ptop='top -stats pid,command,cpu,idlew,power -o power -d'
