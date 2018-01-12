#!/usr/bin/env bash
set -Eeuo pipefail

IFS=$'\n'
randomWords=( $(cat /usr/share/dict/* | shuf -n4) )
unset IFS

randomHash="$(head -c1M /dev/urandom | sha1sum | cut -d' ' -f1)"

echo "${randomWords[@]}" "$randomHash"
