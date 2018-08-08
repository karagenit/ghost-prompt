#!/usr/bin/env bash

# prevent read from turning space/tab into \0
IFS=''

reset=$(tput sgr0)
dim=$(tput dim)
clearline=$(tput el)

bins=$(compgen -c)
input=""

while true; do

    read -rsn1 char

    if [[ "$char" == $'\0' ]] # newline - not \012
    then
        break
    fi

    if [[ "$char" == $'\177' ]] # backspace - not \b, \010, ^?, ^H
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

eval $input
