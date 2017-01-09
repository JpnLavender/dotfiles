#===zsh-theme==================================================
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-patched'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs rbenv)

export ZSH=/Users/iyapih/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# 補完関数の表示を強化する
fpath=(~/.oh-my-zsh/plugins/zsh-completions/src $fpath)
autoload -U compinit && compinit 
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT


#===基本設定==================================================
#プラグインの読み込み
plugins=(git zsh-completions)
# 文字コードの指定
export LANG=ja_JP.UTF-8
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# cdなしでディレクトリ移動
setopt auto_cd
# ビープ音の停止
setopt no_beep
# ビープ音の停止(補完時)
setopt nolistbeep
# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# キーバインディングをvim風
bindkey -v

DEFAULT_USER=$(whoami)

#===時間のかかるコマンドを通知==================================================
export SLACK_USER_NAME='irimamekun'
export SLACK_WEBHOOK_URL='https://hooks.slack.com/services/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'
export SLACK_NOTIF_THRESHOLD=10

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
  "text": "<@$SLACK_USER_NAME>",
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


