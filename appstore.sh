#!/usr/bin/env bash
set -e

echo "Installing apps from AppStore with account '$(mas account)'"
mas install 587512244 # Kaleidoscope (2.2.2)
# mas install 413857545 # Divvy - Window Manager (1.5.2) ## not using it in favour of moom
