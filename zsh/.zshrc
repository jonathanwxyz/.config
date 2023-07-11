#!/bin/env zsh
# Consider exporting ZDOTDIR=$HOME/.config/zsh in /etc/zsh/zshenv
# Not needed when using my nix home-manager config

autoload -U colors && colors # load colors
stty stop undef # disable ctrl-s to freeze terminal
setopt autocd # cd to typed file
setopt interactive_comments

# Set up the prompt

autoload -Uz promptinit
promptinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
if cat /etc/*-release | grep -q "VARIANT=\"Container Image\""; then
    PROMPT="%F{blue}┏━━%f%F{green}%B[%b%~%B]%f %F{grey}container%b%f "\$vcs_info_msg_0_$'\n'"%F{blue}┗━%f %F{blue}%B>%b%f "
else
    PROMPT="%F{cyan}┏━━%f%F{green}%B[%b%~%B]%b%f "\$vcs_info_msg_0_$'\n'"%F{cyan}┗━%f %F{blue}%B>%b%f "
fi
zstyle ':vcs_info:git:*' formats '%F{240}(%b) %r%f'
zstyle ':vcs_info:*' enable git
#prompt adam1

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$XDG_STATE_HOME/zsh/.zsh_history"

# Use modern completion system
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.


# vim bindings
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# get aliases
source $XDG_CONFIG_HOME/shell/aliases

# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# # make install
source $XDG_DATA_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5f5f5f"

[ -f "/var/home/jonathan/.ghcup/env" ] && source "/var/home/jonathan/.ghcup/env" # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/var/home/jonathan/.local/share/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/var/home/jonathan/.local/share/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/var/home/jonathan/.local/share/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/var/home/jonathan/.local/share/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

