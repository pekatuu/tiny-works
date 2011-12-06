# Created by newuser for 4.3.4
source ~/.zshrc-termtitle
PRIVATE_HOST="uilta"

autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

#
# LANG
#
#if [ $HOST = $PRIVATE_HOST ]; then
    export LANG=ja_JP.UTF-8
#else
#    export LANG=ja_JP.EUC-JP
#fi

#
# History
#
HISTFILE=$HOME/.zsh-history
HISTSIZE=51200
SAVEHIST=51200
setopt extended_history
function history-all { history -E 1 }

## Default shell configuration

#
# set prompt
#
setopt PROMPT_SUBST

if [ "${TERM}" = "dumb" ]; then
    PROMPT="${HOST%%.*}[%~]%%%  "
else if [ $HOST = $PRIVATE_HOST ]; then
    PROMPT="%B%{[46m%}${HOST%%.*}%%%{[m%} %b"
    RPROMPT="[%~]"
else 
    PROMPT="%B%{[41m%}${HOST%%.*}%%%{[m%} %b"
    RPROMPT="[%~]"
fi
fi


# dabbrev
HARDCOPYFILE=$HOME/.screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
        local reply lines=80 # 80行分
        screen -X eval "hardcopy -h $HARDCOPYFILE"
        reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
        compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^[/' dabbrev-complete

#
# aliases
#

# ls
alias ls='ls -hCF'

if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b ~/.dir_colors`"
    alias ls='ls --color=auto -hCF' 
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -l'
alias lt="ll -t"
alias ..='cd ../'
alias ../='cd ../'
alias emacs='emacs -reverse --no-splash'
alias emacsnw='\emacs -nw --no-splash'

alias cl='. cl'
alias rdesktop='rdesktop -a 16 -D -z -k ja -g 1280x1024+0+0 '
alias sunflow="java -server -Xmx1000M -jar /usr/share/java/sunflow.jar $*"
alias portsnew='portversion -v | grep -v ='

alias qdic='dic'

alias gl='git log --graph --decorate'
alias gco='git commit'
alias ga='git add'
alias gch='git checkout'
alias gs='git status'
alias gb='git branch'

# suffix aliases
alias -s pdf=evince
alias -s dvi=xdvi
alias -s jar='java -jar '

# global aliases
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g S='| sort'
alias -g U='| uniq'

if [ $HOST != $PRIVATE_HOST ]; then
    alias sudo='echo "\(^o^)/"'
fi

# env
export PATH=${PATH}:/home/g-yamada/bin:/storages/ssd/android-sdk-linux_86/tools
export PYTHONPATH=$PYTHONPATH:$HOME/python/lib:$HOME/python/lib/python2.6/site-packages
export LESS=' -R'
export KIR='kir://pub/kir/g-yamada'
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

