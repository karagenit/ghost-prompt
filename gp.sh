#!/usr/bin/env bash

# prevent read from turning space/tab into \0
IFS=''

reset=$(tput sgr0)
dim=$(tput dim)
clearline=$(tput el)
savepos=$(tput sc)
loadpos=$(tput rc)

bins=$(compgen -c)
input=""

while true; do

    read -rsn1 char

    if [[ "$char" == $'\0' ]] # newline - not \012
    then
        echo "" # line break
        break
    fi

    if [[ "$char" == $'\177' ]] # backspace - not \b, \010, ^?, ^H
    then
        #input=${input::-1}
        input=${input%?}
    elif [[ "$char" != $'\011' ]] # not a tab
    then
        input="${input}${char}"
    fi

    matches=$(echo "$bins" | grep "^${input}")
    first=$(echo "$matches" | head -n 1)

    if [[ "$char" == $'\011' ]]
    then
        input="$first"
    fi

    suffix=${first#"$input"}

    echo -ne "\r${clearline}${input}${savepos}${dim}${suffix}${reset}${loadpos}"
done

eval $input
