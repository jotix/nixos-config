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
alias cdc 'cd ~/arch-config'

### alias helix
alias vim helix
alias vi helix
alias nvim helix

### alias zed
alias zed zeditor

### alias plasma-reload
alias plasma-reload "systemctl restart --user plasma-plasmashell"

alias google_drive_upload "rclone copy ~/Documents jujodeve:"
alias gdu google_drive_upload
alias f1tv 'kwin_wayland "firefox -P" &'
alias 2monitors "kscreen-doctor output.DP-1.enable output.DP-1.position.-1920,450 output.HDMI-A-1.position.0,0"
alias 1monitor "kscreen-doctor output.DP-1.disable output.HDMI-A-1.position.0,0"

alias kde-settings '/home/jotix/arch-config/scripts/kde-settings.sh'

function fish_prompt
    eval $GOPATH/bin/powerline-go -error $status -jobs (count (jobs -p))
end

fastfetch
