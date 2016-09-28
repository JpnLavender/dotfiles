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

alias illust='ssh -i "irimameMac.pem" ec2-user@ec2-54-199-161-164.ap-northeast-1.compute.amazonaws.com'

alias server='ssh -i "irimameMac.pem" ec2-user@ec2-54-199-205-214.ap-northeast-1.compute.amazonaws.com'

# alias docker_rmi='docker rm `docker ps -a -q` & docker images | awk '/^<none>/ { print $3 }' | xargs docker rmi'

function fish_user_key_bindings
  bind \c] peco_history # Bind for prco change directory to Ctrl+]
end

function peco_history
	history | peco | read line; commandline $line
end
