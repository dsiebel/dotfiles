#!/usr/bin/env bash
set -e
set -o pipefail

ERRORS=()

# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' -not -iwholename '*.oh-my-zsh*' \
		-not -iwholename '*.zsh-custom*' | sort -u); do
	if file "$f" | grep --quiet shell; then
		{
			shellcheck -x "$f" && echo "[OK]: sucessfully linted $f"
		} || {
			# add to errors
			ERRORS+=("$f")
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
