# echo "おこるよこれもう。cv:静流"

export EDITOR=vim
export PRODUCTION=true

#Ruby(rbenv)
#  set PATH ~/.rbenv/bin $PATH
set PATH ~/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

eval (direnv hook fish)

alias rm='rmtrash'

alias l='la'

alias t='touch'

alias c='cd'

alias r='ruby'

