_register_keycommand() {
  zle -N $2
  bindkey "$1" $2
}

_buffer_replace() {
  BUFFER="$(cat)"
  CURSOR=$#BUFFER
}

_peco_select() {
  local tx="$(cat)"
  local query="$1"

  if [ "$tx" = '' ]; then
    tx=' '
    query='(nothing)'
  fi

  peco --query "$query" <<< "$tx"
}

_reverse() {
  if which tac > /dev/null; then
    tac <<< $(cat)
  else
    tail -r <<< $(cat)
  fi
}

_is_git_repo() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
}


# ==== peco project ================================================================
peco_ghq_list() {
  ghq list -p \
    | _peco_select \
    | {
        local repo=$(cat)
        if [ -n "$repo" ]; then
          _buffer_replace <<< "cd $repo"
          zle accept-line
        fi
      }
}

_register_keycommand '^]' peco_ghq_list

function peco-z-search
{
  which peco z > /dev/null
  if [ $? -ne 0 ]; then
    echo "Please install peco and z"
    return 1
  fi
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
# bindkey '^h' peco-z-search
_register_keycommand '^n' peco-z-search

# ==== git branch ================================================================
git_branch() {
    git branch -a \
        | peco --prompt "GIT BRANCH>" \
        | head -n 1 \
        | sed -e "s/^\*\s*//g" \
        | {
            local repo=$(cat)
            if [ -n "$repo" ]; then
                _buffer_replace <<< "git checkout $repo"
                zle accept-line
            fi
        }
}

_register_keycommand '^b' git_branch

# ==== peco history ===============================================================
peco_history() {
  \history -n 1 \
    | _reverse \
    | _peco_select "$LBUFFER" \
    | _buffer_replace
}

_register_keycommand '^r' peco_history

# ==== docker ps kill ===============================================================

docker_kill_ps(){
    docker stop $(docker ps -aq) && docker rm $(docker ps -aq )
    docker ps -a
}

docker_kill_img(){
    docker rmi $(docker images -qa)
    docker images -a
}

docker_kill(){
    docker_kill_ps && docker_kill_img
}
docker_delete_volume(){
    sudo rm -rf /var/lib/docker/volumes/*
}

