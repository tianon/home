#!/usr/bin/env bash
set -Eeuo pipefail

# $ sudo apt install 'wamerican.*' 'wbritish.*'
# $ cat /usr/share/dict/* | sort -u | wc -l
# 663022
# 664557
# 667133
# (three different machines -- average ~665000)

# > Math.pow(665000, 4) * Math.pow(16, 40)
# 2.8581557253970005e+71
# > Math.log2(Math.pow(665000, 4) * Math.pow(16, 40))
# 237.37197926020255

IFS=$'\n'
randomWords=( $(cat /usr/share/dict/* | shuf -n4) )
unset IFS

randomHash="$(head -c1M /dev/urandom | sha1sum | cut -d' ' -f1)"

echo "${randomWords[@]}" "$randomHash"
