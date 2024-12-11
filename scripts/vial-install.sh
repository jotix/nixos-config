#!/usr/bin/env bash

### qmk
sudo pacman -S qmk
mkdir -p ~/workspace
cd ~/workspace
git clone https://github.com/vial-kb/vial-qmk.git

export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'

cd ~/workspace/vial-qmk/
qmk setup
