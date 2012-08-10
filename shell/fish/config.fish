# put me in ~/.config/fish/
set git_branch_color green
set mycolor 875f5f


function headrev
  echo (git log --pretty=%h -n 1)
end

function __git_ps1
  set -l g (git rev-parse --git-dir ^/dev/null)
  if [ -n "$g" ]
    set -l r ""
    set -l b ""

    if [ -d "$g/../.dotest" ]
      if [ -f "$g/../.dotest/rebasing" ]
        set r "|REBASE"
      elseif [ -f "$g/../.dotest/applying" ]
        set r "|AM"
      else
        set r "|AM/REBASE"
      end

   set b (git symbolic-ref HEAD ^/dev/null)
    elseif [ -f "$g/.dotest-merge/interactive" ]
      set r "|REBASE-i"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -d "$g/.dotest-merge" ]
      set r "|REBASE-m"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -f "$g/MERGE_HEAD" ]
      set r "|MERGING"
      set b (git symbolic-ref HEAD ^/dev/null)
    else
      if [ -f "$g/BISECT_LOG" ]
        set r "|BISECTING"
      end

      set b (git symbolic-ref HEAD ^/dev/null)
      if [ -z $b ]
        set b (git describe --exact-match HEAD ^/dev/null)
        if [ -z $b ]
          set b (cut -c1-7 "$g/HEAD")
          set b "$b..."
        end
      end
    end

    if not test $argv
        set argv "( %s)"
    end

    set b (echo $b | sed -e 's|^refs/heads/||')

    printf $argv "$b$r" ^/dev/null
  end
end

function fish_prompt
         if test -z (git branch --quiet 2&gt;| awk '/fatal:/ {print "no git"}')
            printf '[%s%s@%s%s|%s|%s%s%s|%s%s%s $] '  (set_color $mycolor) (whoami) (hostname|cut -d . -f 1) (set_color normal) (headrev) (set_color $git_branch_color) (__git_ps1) 
(set_color normal)  (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
         else
            printf '[%s%s@%s%s|%s%s%s $] '  (set_color $mycolor) (whoami) (hostname|cut -d . -f 1) (set_color normal) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
         end
end