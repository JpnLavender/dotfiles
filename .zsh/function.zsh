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


# ==== tmux attach ================================================================
tmux_attach() {
  tmux list-sessions \
    | _peco_select \
    | awk -F: '{ print $1 }' \
    | {
        local session=$(cat)
        if [ -n "$session" ]; then
          title $session
          _buffer_replace <<< "tmux attach -t $session"
          zle accept-line
        fi
      }
}

_register_keycommand '^@' tmux_attach


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

#===時間のかかるコマンドを通知==================================================

if [ -z "${SLACK_WEBHOOK_URL+x}" ]; then
  echo "SLACK_WEBHOOK_URL is empty !!!"
fi

if [ -z "${SLACK_USER_NAME+x}" ]; then
  echo "SLACK_USER_NAME is empty !!!"
fi

function notify_preexec {
  notif_prev_executed_at=`date`
  notif_prev_command=$2
}

function notify_precmd {
  notif_status=$?
  if [ -n "${SLACK_WEBHOOK_URL+x}" ] && [ -n "${SLACK_USER_NAME+x}" ] && [ $TTYIDLE -gt ${SLACK_NOTIF_THRESHOLD:-180} ] && [ $notif_status -ne 130 ] && [ $notif_status -ne 146 ]; then
    notif_title=$([ $notif_status -eq 0 ] && echo "Command succeeded :ok_woman:" || echo "Command failed :no_good:")
    notif_color=$([ $notif_status -eq 0 ] && echo "good" || echo "danger")
    notif_icon=$([ $notif_status -eq 0 ] && echo ":angel:" || echo ":smiling_imp:")
    payload=`cat << EOS
{
  "username": "command result",
  "icon_emoji": "$notif_icon",
  "text": "<@$SLACK_USER_NAME>\n $notif_title",
  "attachments": [
    {
      "color": "$notif_color",
      "title": "$notif_title",
      "mrkdwn_in": ["fields"],
      "fields": [
        {
          "title": "command",
          "value": "\\\`$notif_prev_command\\\`",
          "short": false
        },
        {
          "title": "directory",
          "value": "\\\`$(pwd)\\\`",
          "short": false
        },
        {
          "title": "hostname",
          "value": "$(hostname)",
          "short": true
        },
        {
          "title": "user",
          "value": "$(whoami)",
          "short": true
        },
        {
          "title": "executed at",
          "value": "$notif_prev_executed_at",
          "short": true
        },
        {
          "title": "elapsed time",
          "value": "$TTYIDLE seconds",
          "short": true
        }
      ]
    }
  ]
}
EOS
`
    curl --request POST \
      --header 'Content-type: application/json' \
      --data "$(echo "$payload" | tr '\n' ' ' | tr -s ' ')" \
      $SLACK_WEBHOOK_URL
  fi
}

add-zsh-hook preexec notify_preexec
add-zsh-hook precmd notify_precmd


