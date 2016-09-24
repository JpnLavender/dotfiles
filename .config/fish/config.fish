# echo "おこるよこれもう。cv:静流"

export EDITOR=vim
export PRODUCTION=true
export GOPATH=$HOME/go_file 

#Ruby(rbenv)
#  set PATH ~/.rbenv/bin $PATH
set PATH ~/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

eval (direnv hook fish)

alias l='la'

alias t='touch'

alias c='cd'

alias r='ruby'

alias dl='~/Desktop/AllFile/Programming/youtube-dl/youtube_dl.sh'
