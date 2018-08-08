#!/usr/bin/env bash

reset=$(tput sgr0)
dim=$(tput dim)
clearline=$(tput el)

bins=$(compgen -c)
input=""

while true; do

    read -rsn1 char

    if [[ "$char" == $'\177' ]]
    then
        #input=${input::-1}
        input=${input%?}
    else
        input="${input}${char}"
    fi

    matches=$(echo "$bins" | grep "^${input}")
    first=$(echo "$matches" | head -n 1)

    firstrest=${first#"$input"}

    echo -ne "${clearline}${input}${dim}${firstrest}${reset}\r"
done
