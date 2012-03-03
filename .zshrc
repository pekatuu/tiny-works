# Created by newuser for 4.3.4
#source ~/.zshrc-termtitle

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

case $HOST in
"amaretto")
	export SCREEN_CAPTION_NONE=bW
	export SCREEN_CAPTION_SELECTED=Wb
	prompt_bg=44
	;;
"corsica")
	export SCREEN_CAPTION_NONE=gk
	export SCREEN_CAPTION_SELECTED=kg
	prompt_bg=42
	;;
*)
	export SCREEN_CAPTION_NONE=rk
	export SCREEN_CAPTION_SELECTED=kr
	prompt_bg=41
	;;
esac




#
# set prompt
#
setopt PROMPT_SUBST

if [ "${TERM}" = "dumb" ]; then
    PROMPT="${HOST%%.*}[%~]%%%  "
else
    PROMPT="%B%{[${prompt_bg}m%}${HOST%%.*}%%%{[m%} %b"
    RPROMPT="[%~]"
fi

# title
if [ "${TERM%%-*}" = "screen" ]; then
    local -a host; host=`/bin/hostname -s`
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        echo -n "k$host:$cmd[1]:t\\"
    }
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
#    eval "`dircolors -b ~/.dir_colors`"
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
alias emacs="emacs -r --no-splash"
alias ec="emacsclient -c "

alias gl='git log ' 
alias gcm='git commit -m'
alias ga='git add'
alias gco='git checkout'
alias gs='git status'
alias gb='git branch'
alias gd="git diff"

# suffix aliases
alias -s pdf=evince
alias -s dvi=xdvi
alias -s jar='java -jar '

# global aliases
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g GV='| grep -v '
alias -g S='| sort'
alias -g U='| uniq'

# env
export JAVA_HOME=/usr/java/default
export PATH=${PATH}:${HOME}/bin:${HOME}/share/jruby-1.6.6/bin:${JAVA_HOME}/bin
export LESS=' -R'
