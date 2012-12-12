alias -- -='cd -'
alias ls='ls -h --color=auto'
alias l='ls -l'
alias ll='ls -lA'
alias la='ls -la'
alias lt='ls -ltr'
alias RM='rm -irf'

duh() { # disk usage for humans
  test $# -eq 0 && set -- *
  du -sch "$@" | sort -h
}

alias tree='tree -ACF'

bam() { # backup with move
  for file; do
    mv -v $file{,.bak}
  done
}

bum() { # undo backup move
  for file; do
    mv -v "$file" "${file%.bak}"
  done
}

bac() { # backup with copy
  for file; do
    cp -Rpv "$file" "$file~$(date -Ins)~"
  done
}

buc() { # undo backup copy
  for file; do
    dest=${file%%\~*}
    test -d "$dest" && mv -v "$dest" "$file.orig"
    mv -v "$file" "$dest"
  done
}

mount-dir-ro() {
  sudo mount --bind "$@" &&
  sudo mount -o remount,ro,bind "$@"
}
