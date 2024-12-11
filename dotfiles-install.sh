#!/usr/bin/env bash

DOTFILES_DIR=$PWD/dotfiles
HOME_DIR=/home/jotix
BACKUP_DIR=$HOME_DIR/.dotfiles-backup

mkdir -p $BACKUP_DIR

process-file() {

    FILE=$@
    FILE_RELATIVE=$(echo $FILE | sed "s,$DOTFILES_DIR,,g")
    DESTINY=$HOME_DIR$FILE_RELATIVE
    # replace the slashs and dots with underscores in the backup files path
    BACKUP_FILE=$BACKUP_DIR/$(echo $FILE_RELATIVE | sed -r 's/[/.]+/_/g') 
    
    echo procesing $FILE
    if [ -d $FILE ]; then

	mkdir -p $DESTINY

    else

	if [ -f $DESTINY ]; then
	    echo the file $DESTINY exists, moving it to $BACKUP_DIR
	    mv $DESTINY $BACKUP_FILE
	fi
	ln -sf $FILE $DESTINY

    fi
    
}

find $DOTFILES_DIR | while read -r file; do  process-file $file; done
