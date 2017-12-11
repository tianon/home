#!/usr/bin/env bash
set -Eeuo pipefail

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

sed -ri 's!^(HIST[A-Z]*SIZE=)!#\1!' "$HOME/.bashrc"

if ! grep -q "$thisDir" "$HOME/.bashrc"; then
	echo $'\n'"source '$thisDir/bashrc'" >> "$HOME/.bashrc"
fi
