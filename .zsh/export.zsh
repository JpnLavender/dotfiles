export EDITOR=nvim
export XDG_CONFIG_HOME=~/.config

export GOPATH=$HOME/.go_files
export PATH="$GOPATH/bin:$PATH"

eval "$(direnv hook zsh)"

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.zsh.d/z.sh

source ~/.fonts/*.sh

export TERM="xterm-256color"

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - zsh)"
fi
