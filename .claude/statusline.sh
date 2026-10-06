#!/bin/bash
# Claude Code status line: context | model + effort | repo + branch | cost + duration | lines changed.
input=$(cat)
command -v jq >/dev/null 2>&1 || { echo "statusline: jq missing"; exit 0; }

IFS=$'\x1f' read -r model pct used size effort think dir cost dur_ms add del < <(
  printf '%s' "$input" | jq -r '[
    (.model.display_name // .model.id // "?"),
    (.context_window.used_percentage // "" | tostring),
    ((.context_window.total_input_tokens // "") | tostring),
    ((.context_window.context_window_size // "") | tostring),
    (.effort.level // "-"),
    (if .thinking.enabled == true then "on" elif .thinking.enabled == false then "off" else "-" end),
    (.workspace.current_dir // .cwd // ""),
    ((.cost.total_cost_usd // "") | tostring),
    ((.cost.total_duration_ms // "") | tostring),
    ((.cost.total_lines_added // "") | tostring),
    ((.cost.total_lines_removed // "") | tostring)
  ] | join("\u001f")'
)

if [ -z "${NO_COLOR:-}" ]; then
  R=$'\e[31m'; G=$'\e[32m'; Y=$'\e[33m'; C=$'\e[36m'; D=$'\e[2m'; X=$'\e[0m'
else
  R=; G=; Y=; C=; D=; X=
fi

human() { awk -v n="$1" 'BEGIN{ if (n>=1000000) printf "%.1fM", n/1000000; else if (n>=1000) printf "%.1fk", n/1000; else printf "%d", n }'; }

# context bar (a fresh session has no usage data yet: show it as empty)
p=${pct%.*}; [ -z "$p" ] && p=0
[ -z "$used" ] && [ -n "$size" ] && used=0
filled=$(( p / 10 )); [ $filled -gt 10 ] && filled=10
bar=$(printf '%*s' "$filled" '' | tr ' ' '█')$(printf '%*s' $((10 - filled)) '' | tr ' ' '░')
if [ "$p" -ge 80 ]; then col=$R; elif [ "$p" -ge 50 ]; then col=$Y; else col=$G; fi
tok=""
[ -n "$used" ] && [ -n "$size" ] && tok=" $(human "$used")/$(human "$size")"
ctx="${col}${bar} ${p}%${X}${D}${tok}${X}"

# order: context | model + effort | repo + branch | cost + duration | changes
out="$ctx"

# model + effort
mdl="${C}${model}${X}"
[ "$effort" != "-" ] && mdl="$mdl ${D}${effort}${X}"
out="$out | $mdl"

# repo (or dir name) + branch
if [ -n "$dir" ]; then
  g() { git --no-optional-locks -C "$dir" "$@" 2>/dev/null; }
  name=$(basename "$dir"); gitinfo=""
  if br=$(g symbolic-ref --short -q HEAD || g rev-parse --short HEAD); then
    remote=$(g remote get-url origin)
    if [ -n "$remote" ]; then name=$(basename "${remote%.git}"); else name=$(basename "$(g rev-parse --show-toplevel)"); fi
    [ -n "$(g status --porcelain | head -1)" ] && br="$br*"
    gitinfo=" ${Y}${br}${X}"
  fi
  out="$out | $name$gitinfo"
fi

# cost + duration
tail=""
[ -n "$cost" ] && tail=$(awk -v c="$cost" 'BEGIN{printf "$%.2f", c}')
if [ -n "$dur_ms" ]; then
  s=$(( ${dur_ms%.*} / 1000 ))
  t=$(printf '%dm%02ds' $((s / 60)) $((s % 60)))
  tail="${tail:+$tail }$t"
fi
[ -n "$tail" ] && out="$out | $tail"

# lines changed
{ [ -n "$add" ] && [ "$add" != "0" ]; } || { [ -n "$del" ] && [ "$del" != "0" ]; } && out="$out | ${G}+${add:-0}${X} ${R}-${del:-0}${X}"

printf '%s\n' "$out"
