#!/usr/bin/env bash

reset=$(tput sgr0)
dim=$(tput dim)
clearline=$(tput el)

bins=$(compgen -c)
input=""

while true; do

    read -rsn1 char

    # TODO: handle backspace?

    input="${input}${char}"

    matches=$(echo "$bins" | grep "^${input}")
    first=$(echo "$matches" | head -n 1)

    firstrest=${first#"$input"}

    echo -ne "${clearline}${input}${firstrest}\r"
done
