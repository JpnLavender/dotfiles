export EDITOR=vim
export GOPATH=$HOME/go_files

eval "$(direnv hook zsh)"

export ZSH=/Users/iyapih/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"

source .bashrc

powerline-daemon -q
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
