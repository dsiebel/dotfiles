#!/usr/bin/env bash

readonly EXTENSIONS="${1:-${PWD}/vscode/extensions.txt}"

if [[ -f "${EXTENSIONS}" ]]; then
	echo
	echo "Installing vscode extensions from ${EXTENSIONS}"
	while read -r ext; do
		code --install-extension "${ext}"
	done < <(cat "${EXTENSIONS}")
	echo
fi
