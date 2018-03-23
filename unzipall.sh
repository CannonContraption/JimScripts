#!/bin/bash

while read file; do
    refile=$(echo $file | sed -e 's/\.zip//g' -e 's/..\///g')
    if echo "$file" | grep "\.zip" > /dev/null 2>&1; then
        echo -e "\033[1;32mzip\033[m"
        echo "$refile"
        mkdir "$refile"
        unzip -d "$refile" "$file"
    else
        echo -e "\033[1;31mNOT ZIP\033[m"
        echo $file
    fi
    #echo "$refile"
    #mkdir "$refile"
    #unzip -d "$refile" "$file"
done
