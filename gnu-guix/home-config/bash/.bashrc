# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
[ -f /etc/bashrc ] && source /etc/bashrc

alias grep='grep --color=auto'
alias ip='ip -color=auto'

export EDITOR='emacs -nw'
export VISUAL=emacs

source /gnu/store/dzn7mlkkxwjpl6jj2f6lrk4bx2fji0nc-liquidprompt-2.1.2/share/liquidprompt/liquidprompt
#source /gnu/store/dzn7mlkkxwjpl6jj2f6lrk4bx2fji0nc-liquidprompt-2.1.2/share/liquidprompt/themes/powerline/powerline.theme

neofetch
