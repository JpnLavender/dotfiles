#! /bin/bash

#othefile
function copy_otherfile {
    echo "------------------------------ setup setting files ------------------------------"
    for filename in .pryrc .tmux.conf .vimperatorrc .vimrc .zshrc; do
        ln $HOME/dotfiles/$filename $HOME/$filename
    done
}

#zshrc
function copy_zshrc {
    echo "------------------------------ setup zsh ------------------------------"
    mkdir $HOME/.zsh
    for filename in alias basic export function ; do
        ln $HOME/dotfiles/.zsh/$filename.zsh $HOME/.zsh/$filename.zsh
    done
}

function install_oh_my_zsh {
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # install oh-my-zsh plugin to zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
}

#install-tmux-powerline

function install_tmux_powerline {
    echo "------------------------------ setup tmux_powerline ------------------------------"
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
    echo "------------------------------ setup vim ------------------------------"
    mkdir -p $HOME/.vim/colors
    cp $HOME/dotfiles/.vim/colors/solarized.vim $HOME/.vim/colors/solarized.vim
    for filename in basic bundle color indent key path plugin theme; do
        ln $HOME/dotfiles/.vim/.vimrc.$filename $HOME/.vim/.vimrc.$filename
    done
}

#install-package
function install_package {
    echo "------------------------------ install package ------------------------------"
    sudo apt install -y zsh vim git tmux tig
}

#default-change-shell
function change_default_shell {
    echo "デフォルトShellをZshに変更します"
    zsh_path=$(which zsh)
    chsh -s $zsh_path
}

#anyenv-install & rbenv
function anyenv_install {
    echo "------------------------------ install anyenv ------------------------------"
    # install anyenv
    git clone https://github.com/riywo/anyenv ~/.anyenv
    # anyenv using install rbrnv
    exec $SHELL -l
    anyenv install rbenv
    exec $SHELL -l
    # install ruby 2.4.0
    rbenv install 2.4.0
    rbenv rehash
    # set global ruby version
    rbenv global 2.4.0
}

copy_otherfile
copy_zshrc
install_oh_my_zsh
install_tmux_powerline
copy_vimrc
install_package
change_default_shell
anyenv_install
