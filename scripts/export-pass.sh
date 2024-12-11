#!/bin/bash
# export passwords to external file

shopt -s nullglob globstar
prefix=${PASSWORD_STORE_DIR:-$HOME/.password-store}
outfile=${1:-exported_passes}

for file in "$prefix"/**/*.gpg; do
    echo $file
    printf "$file\n" >> $outfile
    #file="${file/$prefix/}"
    #printf "%s\n" "Name: ${file%.*}" >> $outfile
    #pass "${file%.*}" >> $outfile
    gpg2 --decrypt "${file}" >> "$outfile"
    printf "\n\n" >> $outfile
done
