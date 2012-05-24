PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f%b%(!.#.$) '

autoload -U compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' menu yes select

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt AUTO_CD BSD_ECHO

_force_rehash() {
 (( CURRENT == 1 )) && rehash
 return 1
}

zstyle ':completion:::::' completer _force_rehash _complete

setopt SH_WORD_SPLIT #пробелы как в bash

if [ -e $HOME/.ssh/known_hosts ] ; then
 hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
 zstyle ':completion:*:hosts' hosts $hosts
fi

typeset -U path cdpath fpath manpath

autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on # C-x C-z
bindkey "^Z" predict-off # C-z

autoload -U zcalc zed

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

bindkey '^[[3~' delete-char
bindkey '^E' expand-cmd-path

alias df='df -h'
alias du='du -sh'
alias grep='egrep --color=auto'

hash -d data=/Volumes/Data\ HD/
hash -d itunes=/Volumes/Data\ HD/Music/iTunes\ Music/

[ -r /etc/debian_version ] && [ -x 'which sudo' ] && alias upgrade='sudo apt-get update && sudo apt-get -u upgrade'

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/python:/usr/local/mysql/bin:/usr/local/share/npm/bin:/usr/local/narwhal/bin/:$PATH"
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
export ARCHFLAGS="-arch x86_64"

# python
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

alias sshneutrino='ssh evindor@li347-90.members.linode.com'
alias sshdev2='ssh evindor@dev2.ostrovok.ru'
alias cdo='cd ~/ostrota'
alias cde='cd ~/extrota'
alias cdcs='cd ~/CodingStuff'
alias mng='python manage.py'
alias runs='python manage.py runserver'
alias serv='python manage.py runserver 0.0.0.0:8000'
alias woe='workon extrota'
alias vimconf='vim ~/.vimrc'
alias v='vim'

alias gsl="git stash list"
alias gsp="git stash pop"
alias gss="git stash save"
alias gsa="git stash apply"

function current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
# compdef ggpull=git
alias ggpush='git push origin $(current_branch)'
