#!/usr/bin/env bash

readonly EXTENSIONS="${1:-${PWD}/vscode/extensions.txt}"

if [[ -f "${EXTENSIONS}" ]]; then
    echo
    echo "Installing vscode extensions from ${EXTENSIONS}"
    for ext in $(cat "${EXTENSIONS}"); do
        code --install-extension "${ext}"
    done
    echo
fi
