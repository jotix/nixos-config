#!/usr/bin/env bash

find .  \( -type f -o -type l \) -print0 | sed -z "s|^.|$HOME|" | xargs -0 -I{} rm {}
