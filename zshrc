# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz promptinit
promptinit

prompt_seb_setup() {
    is_root=$(test "$EUID" -eq 0; echo $?)
    RPROMPT="[%D{%H:%M:%S}]"
    if [[ $is_root == 0 ]]; then
        PROMPT="
%f%b[%~] %b%F{red}%m%f%b [%F{yellow}%?%f]
%K{red}%#%f%b%k "
    else
        # default colors: (name);(hostname);(exit code)
        # magenta;blue;yellow
        # or: 121;69;11
        PROMPT="
%f%b[%~] %B%F{121}%n %B%F{69}%m%f%b [%F{11}%?%f]
%# "
    fi
}

prompt_themes+=( seb )

prompt seb

export SebCfgDir=$(dirname `readlink -f $HOME/.zshrc` )

source $SebCfgDir/aliases

if [ -f "$HOME/reminders" ]; then
    if [ -s "$HOME/reminders" ]; then
        echo -e "Reminders:\n----------"
        cat $HOME/reminders
        echo "----------"
    fi
fi

if [ -f "$HOME/.zsh-extras" ]; then
    # if we have any other things for zsh to source that are specific
    # to one system, source them here
    source $HOME/.zsh-extras
fi
