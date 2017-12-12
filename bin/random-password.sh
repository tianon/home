#!/bin/bash
set -e

IFS=$'\n'
randomWords=( $(cat /usr/share/dict/* | shuf -n4) )
unset IFS

randomHash="$(head -c1M /dev/urandom | sha1sum | cut -d' ' -f1)"

echo "${randomWords[@]}" "$randomHash"
