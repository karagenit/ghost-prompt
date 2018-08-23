#!/usr/bin/env bash

# prevent read from turning space/tab into \0
IFS=''

bins=$(compgen -c)
input=""

echo -n "$(tput sc)"

while true; do

    read -rsn1 char

    if [[ "$char" == $'\0' ]] # newline - not \012
    then
        echo "" # line break
        break
    fi

    if [[ "$char" == $'\177' ]] # backspace - not \b, \010, ^?, ^H
    then
        input=${input%?}
    elif [[ "$char" != $'\011' ]] # not a tab
    then
        input="${input}${char}"
    fi

    # Find a command that matches the current input
    matches=$(echo "$bins" | grep "^${input}")
    first=$(echo "$matches" | head -n 1)

    if [[ "$char" == $'\011' ]] # tab autocomplete
    then
        input="$first"
    fi

    # Display the rest of the first command in grey
    suffix=${first#"$input"}
    suflen=${#suffix}

    # tput cub 0 still moves it back 1, so we don't print anything if suflen is zero
    if [[ $suflen != 0 ]]; then
        move="$(tput cub ${suflen})"
    else
        move=""
    fi

    echo -ne "$(tput rc)$(tput el)${input}$(tput dim)${suffix}$(tput sgr0)${move}"
done

eval $input
