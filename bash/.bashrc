#
# ~/.bashrc
#

export SSH_AUTH_SOCK=~/.1password/agent.sock

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# run fastfetch every time a new terminal is opened if fastfetch is installed
if command -v fastfetch &> /dev/null; then
    fastfetch
fi


alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
source /usr/share/nvm/init-nvm.sh
alias waybar-reload='pkill waybar && (waybar > /dev/null 2>&1 &)'

