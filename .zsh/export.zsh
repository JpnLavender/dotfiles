export EDITOR=vim

export GOPATH=$HOME/.go_files
export PATH="$GOPATH/bin:$PATH"

export SCALA_HOME=/path/to/scala_dir
export PATH=$PATH:$SCALA_HOME/bin

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export IDEA_JDK=$JAVA_HOME

eval "$(direnv hook zsh)"

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - zsh)"
fi

export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
export SLACK_USER_NAME="irimamekun"
