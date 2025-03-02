#
# config.fish
#

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g -x EDITOR helix
set -g -x VISUAL zeditor
set -g -x PATH $PATH:~/.local/bin:~/.scripts
set -g -x GOPATH ~/go

alias ls 'ls --color=auto'
alias grep 'grep --color=auto'

alias exa 'exa --icons'
alias la 'exa -lha'
alias l la
alias ll 'exa -l'
alias ls exa
alias lt 'exa --tree'
alias gitroot 'cd $(git rev-parse --show-toplevel)'
alias gr 'gitroot'

### camara negocio
alias camara 'mpv rtsp://jujodeve:SuperJoti3275@192.168.0.6/stream1 --profile=low-latency --no-audio'

### arch-config
alias cdc 'cd ~/nixos-config'

### NixOS alias
alias rebuild "sudo nixos-rebuild switch --flake .#$HOSTNAME"
alias rebuild-boot "sudo nixos-rebuild boot --flake .#$HOSTNAME"

### alias zed
alias zed zeditor

alias google_drive_upload "rclone copy ~/Documents jujodeve:"
alias gdu google_drive_upload

function fish_prompt
    eval powerline-go -error $status -jobs (count (jobs -p))
end

fastfetch
