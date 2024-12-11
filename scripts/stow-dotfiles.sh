#!/bin/bash

jtx-stow(){
  stow  --stow --dir=./dorfiles --target=$HOME --no-folding . $@
}

backup-dotfiles(){
  mkdir -p $HOME/.dotfiles-backup
  FIND="* existing target is neither a link nor a directory: "
  jtx-stow --no 2>&1 | grep "$FIND" | sed "s/$FIND//" | xargs -I "{}" mv -v $HOME/{} $HOME/.dotfiles-backup/
}

### check if error
jtx-stow --no 2>&1

if [ $? -ne 0 ]; then
  echo "backing up existing dotfiles..."
  backup-dotfiles
fi

### stowing the dotfiles
echo "stowing dotfiles..."
jtx-stow -v

