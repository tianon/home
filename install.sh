#!/usr/bin/env bash
set -Eeuo pipefail

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

sed -ri 's!^(HIST[A-Z]*SIZE=)!#\1!' "$HOME/.bashrc"

if ! grep -q "$thisDir" "$HOME/.bashrc"; then
	echo $'\n'"source '$thisDir/bashrc'" >> "$HOME/.bashrc"
fi

touch "$HOME/.tmux.conf"
if ! grep -q "$thisDir" "$HOME/.tmux.conf"; then
	[ -s "$HOME/.tmux.conf" ] && echo >> "$HOME/.tmux.conf"
	echo "source-file '$thisDir/tmux.conf'" >> "$HOME/.tmux.conf"
fi

touch "$HOME/.inputrc"
if ! grep -q "$thisDir" "$HOME/.inputrc"; then
	[ -s "$HOME/.inputrc" ] && echo >> "$HOME/.inputrc"
	echo "\$include $thisDir/inputrc" >> "$HOME/.inputrc"
fi
