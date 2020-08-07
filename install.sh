#!/usr/bin/env bash
set -Eeuo pipefail

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

if [ -e "$HOME/.bashrc" ]; then
	sed -ri 's!^(HIST[A-Z]*SIZE=)!#\1!' "$HOME/.bashrc"
fi

declare -A files=(
	["$HOME/.bashrc"]="source '$thisDir/bashrc'"
	["$HOME/.inputrc"]="\$include $thisDir/inputrc"
	["$HOME/.ssh/config"]="Include $thisDir/ssh-config.d/*"
	["$HOME/.tmux.conf"]="source-file '$thisDir/tmux.conf'"
)

# Debian includes a default ~/.profile that loads bashrc, but Alpine doesn't, so if ~/.profile doesn't exist or doesn't mention bashrc, let's adjust it too
if [ ! -e "$HOME/.profile" ] || ! grep -q bashrc "$HOME/.profile"; then
	files["$HOME/.profile"]='[ -z "$BASH_VERSION" ] || . "$HOME/.bashrc"'
fi

if [ ! -d "$HOME/.ssh" ]; then
	mkdir "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"
fi
if [ ! -d "$HOME/.ssh/sockets" ]; then
	mkdir "$HOME/.ssh/sockets"
fi

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

if [ ! -d "$HOME/.vim/pack/tianon" ]; then
	mkdir -p "$HOME/.vim/pack"
	ln -sfT "$thisDir/vim-pack-tianon" "$HOME/.vim/pack/tianon"
fi
