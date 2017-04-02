#! /bin/bash

copy_otherfile
copy_zshrc
copy_vimrc
install_package
change_default_shell
anyenv_install

#othefile
function copy_otherfile{
    for filename in $(ls -a);do
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
    git clone https://github.com/riywo/anyenv ~/.anyenv
    anyenv install rbenv
    exec $SHELL -l
    rbenv install 2.4.0
    rbenv rehash
    rbenv global 2.4.0
}
