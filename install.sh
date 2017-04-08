#! /bin/bash

copy_otherfile
copy_zshrc
install_oh_my_zsh
install_tmux_powerline
copy_vimrc
install_package
change_default_shell
anyenv_install

#othefile
function copy_otherfile{
    for filename in .pryrc .tmux.conf .vimperatorrc .vimrc .zshrc; do
        cp --backup $filename $HOME
    done
}

#zshrc
function copy_zshrc {
    mkdir $HOME/.zsh && cd &_
    for filename in alias basic export function ; do
        cp --backup $filename.zsh
    done
}

function install_oh_my_zsh {
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # install oh-my-zsh plugin to zsh-autosuggestions
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
}

#install-tmux-powerline

function install_tmux_powerline {
    #Download tmux powerline
    git clone https://github.com/erikw/tmux-powerline.git ~/tmux-powerline
    #Download tmux-plugin management
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    # Remove Initialize default Config file
    rm -rf ~/tmux-powerline/themes/default.sh
    # Input New Config file
    ln -s ~/dotfiles/default.sh ~/tmux-powerline/themes/default.sh
}

#vimrc
function copy_vimrc {
    mkdir $HOME/.vim && cd &_
    for filename in basic bundle color indent key path plugin theme; do
        cp --backup .vimrc.$filename
    done
}

#install-package
function install_package{
    for package in zsh vim git; do
        sudo apt-get install $package
    done
}

#default-change-shell
function change_default_shell{
    echo "デフォルトShellをZshに変更します"
    zsh_path=$(which zsh)
    chsh -s $zsh_path
}

#anyenv-install & rbenv
function anyenv_install{
    # install anyenv
    git clone https://github.com/riywo/anyenv ~/.anyenv
    # anyenv using install rbrnv
    anyenv install rbenv
    exec $SHELL -l
    # install ruby 2.4.0
    rbenv install 2.4.0
    rbenv rehash
    # set global ruby version
    rbenv global 2.4.0
}
