#!/usr/bin/env bash

### steam 

flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user
flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user
