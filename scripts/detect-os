#!/usr/bin/env bash

if [[ -f /etc/os-release ]]; then
	# freedesktop.org and systemd
	# shellcheck disable=SC1091
	. /etc/os-release
	OS_NAME="${NAME}"
	OS_VERSION="${VERSION_ID}"
elif type lsb_release >/dev/null 2>&1; then
	# linuxbase.org
	OS_NAME="$(lsb_release -si)"
	OS_VERSION="$(lsb_release -sr)"
elif [[ -f /etc/lsb-release ]]; then
	# For some versions of Debian/Ubuntu without lsb_release command
	# shellcheck disable=SC1091
	. /etc/lsb-release
	OS_NAME=$DISTRIB_ID
	OS_VERSION=$DISTRIB_RELEASE
elif [[ -f /etc/debian_version ]]; then
	# Older Debian/Ubuntu/etc.
	OS_NAME=Debian
	OS_VERSION="$(cat /etc/debian_version)"
else
	# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
	OS_NAME="$(uname -s)"
	OS_VERSION="$(uname -r)"
fi

export OS_NAME OS_VERSION
