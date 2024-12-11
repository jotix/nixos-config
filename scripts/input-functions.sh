#!/bin/bash
### bash input functions

### read y or n from keyboard
read_y_or_n(){
    INPUT=""
    while [[ "$INPUT" != "y" && "$INPUT" != "n" ]]; do
        read -p "$1 (y/n) " INPUT; echo >&2
    done
    echo $INPUT
}

### set_password "message" minimun_lenght
set_password() {
    PASS1=""
    PASS2=""
    while [[ "$PASS1" != "$PASS2" ]] || [[ ${#PASS1} < $2 ]]; do
        read -sp "$1 (minimum $2 chars): " PASS1; echo >&2
        read -sp "confirm password: " PASS2; echo >&2
        if  [[ "$PASS1" != "$PASS2" ]]; then
            echo "the passwords don't match." >&2
        elif [[ $(count_chars $PASS1) < $2 ]]; then
            echo "the password is too short." >&2
        fi
    done
}

### read_input "message" minimun_lenght
read_input() {
    INPUT=""
    while [[ ${#INPUT} < $2 ]]; do
        read -p "$1 (minimum $2 chars): " INPUT
        if [[ $(count_chars $INPUT) < $2 ]]; then
            echo "too short." >&2
        fi
    done
    echo $INPUT
}

### count characters
count_chars() {
    echo -n "$1" | wc -c
}
