#!/bin/bash
set -e

win="$(xdotool getactivewindow)"

class="$(xprop -id "$win" | awk '/^WM_CLASS/ { split($3, a, "\""); print a[2] }')"
case "$class" in
	Terminal|gnome-terminal|xfce4-terminal)
		;;
	*)
		echo >&2 "error: refusing to resize window of class: $class"
		exit 1
		;;
esac

exec xdotool windowsize --usehints "$win" "${1:-80}" "${2:-24}"
