#!/usr/bin/env bash

while true; do

    read -rsn1 char
    bins=$(compgen -c | grep "^${char}")
    first=$(echo "$bins" | head -n 1)
    echo $first
done
