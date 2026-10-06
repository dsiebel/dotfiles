#!/bin/bash
# Claude Code status line: context | model + effort | repo + branch | cost | lines changed.
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

# Nerd Font icons for the repo/branch/path segment only (bash 3.2-safe byte escapes); set STATUSLINE_NO_ICONS=1 to disable
if [ -z "${STATUSLINE_NO_ICONS:-}" ]; then
  I_REPO=$'\xef\x90\x81 '; I_BRANCH=$'\xee\x9c\xa5 '; I_DIR=$'\xef\x81\xbc '
else
  I_REPO=; I_BRANCH=; I_DIR=
fi

# trunc STRING MAX: cut to MAX chars, ending in … when shortened
trunc() { if [ "${#1}" -gt "$2" ]; then printf '%s…' "${1:0:$(($2 - 1))}"; else printf '%s' "$1"; fi; }

# abbrev_path PREFIX REL: fish-style, parent dirs shrink to their first letter (.config -> .c), leaf stays (cut at 18)
abbrev_path() {
  local leaf="${2##*/}" parent="" c
  if [ "$2" != "$leaf" ]; then
    local IFS=/
    for c in ${2%/*}; do
      [ "${c:0:1}" = "." ] && parent="$parent${c:0:2}/" || parent="$parent${c:0:1}/"
    done
  fi
  printf '%s%s%s' "$1" "$parent" "$(trunc "$leaf" 18)"
}

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

# order: context | model + effort | repo + branch | cost | changes
out="$ctx"

# model + effort
mdl="${C}${model}${X}"
[ "$effort" != "-" ] && mdl="$mdl ${D}${effort}${X}"
out="$out | $mdl"

# repo + branch; outside a repo: ~-relative path if short enough, else fish-style ~/w/s/leaf; same for paths outside ~ (/v/l/leaf)
if [ -n "$dir" ]; then
  g() { git --no-optional-locks -C "$dir" "$@" 2>/dev/null; }
  if br=$(g symbolic-ref --short -q HEAD || g rev-parse --short HEAD); then
    remote=$(g remote get-url origin)
    if [ -n "$remote" ]; then name=$(basename "${remote%.git}"); else name=$(basename "$(g rev-parse --show-toplevel)"); fi
    br=$(trunc "$br" 24)
    [ -n "$(g status --porcelain | head -1)" ] && br="$br*"
    out="$out | ${I_REPO}$(trunc "$name" 18) ${Y}${I_BRANCH}${br}${X}"
  elif [ "$dir" = "$HOME" ]; then
    out="$out | ${I_DIR}~"
  else
    if [[ "$dir" == "$HOME"/* ]]; then disp="~${dir#"$HOME"}"; pre="~/"; rel="${dir#"$HOME"/}"
    else disp="$dir"; pre="/"; rel="${dir#/}"; fi
    [ "${#disp}" -gt 24 ] && disp=$(abbrev_path "$pre" "$rel")
    out="$out | ${I_DIR}$disp"
  fi
fi

# cost
[ -n "$cost" ] && out="$out | $(awk -v c="$cost" 'BEGIN{printf "$%.2f", c}')"

# lines changed
{ [ -n "$add" ] && [ "$add" != "0" ]; } || { [ -n "$del" ] && [ "$del" != "0" ]; } && out="$out | ${G}+${add:-0}${X} ${R}-${del:-0}${X}"

printf '%s\n' "$out"
