alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

alias hcomposer='hhvm /usr/local/bin/composer'

alias gds='git diff --staged'

alias hosts='sudo vim /etc/hosts; dscacheutil -flushcache'

alias use_php54="brew unlink php56 && brew unlink php70 && brew link php54"
alias use_php56="brew unlink php54 && brew unlink php70 && brew link php56"
alias use_php70="brew unlink php54 && brew unlink php56 && brew link php70"
