#!/bin/bash

compressed_file=$1

while true; do
    7z l $compressed_file > /dev/null 2>&1

    if [ "$(echo $?)" == "0" ]; then
        7z x $compressed_file > /dev/null 2>&1
        compressed_file=$(7z l $compressed_file | grep "Name" -A 2 | tail -n 1 | awk NF'{print $NF}')
    else 
        password=$(cat $compressed_file | awk NF'{print $NF}'); rm data* 2>/dev/null
        echo $password
        exit 0
    fi
done