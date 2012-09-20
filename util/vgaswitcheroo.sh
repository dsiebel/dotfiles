#!/bin/bash

MSG=$1

if [[ "SHOW" = "$1" ]]; then
	cat /sys/kernel/debug/vgaswitcheroo/switch
else
	if [[ "" != "$1" ]]; then
		echo $1 > /sys/kernel/debug/vgaswitcheroo/switch
	else
		exit 2
	fi
fi
exit 0
