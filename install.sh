#!/usr/bin/env bash
set -Eeuo pipefail

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

sed -ri 's!^(HIST[A-Z]*SIZE=)!#\1!' "$HOME/.bashrc"

declare -A files=(
	["$HOME/.bashrc"]="source '$thisDir/bashrc'"
	["$HOME/.tmux.conf"]="source-file '$thisDir/tmux.conf'"
	["$HOME/.inputrc"]="\$include $thisDir/inputrc"
)

for f in "${!files[@]}"; do
	if [ ! -e "$f" ] || ! grep -q "$thisDir" "$f"; then
		line="${files[$f]}"
		printf "updating %q -- %s\n" "$f" "$line"
		if [ -s "$f" ]; then
			echo >> "$f"
		fi
		echo "${files[$f]}" >> "$f"
	fi
done
