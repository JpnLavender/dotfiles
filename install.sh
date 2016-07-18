#! /bin/bash
if [ -d ~/dotfiles ]; then
    if [ ! -e ~/.vimrc ]; then
        ln -s ~/dotfiles/.vimrc ~/.vimrc
    elif [ ! -e ~/.vim ]; then
        ln -s ~/dotfiles/.vim ~/.vim
    elif [ ! -e ~/.config ]; then
        ln -s ~/dotfiles/.config ~/.config
    elif [ ! -e ~/.tmux.conf ]; then
        ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    elif [ ! -e ~/.viminfo ]; then
        ln -s ~/dotfiles/.viminfo ~/.viminfo
    elif [ ! -e ~/.vimperator ]; then
        ln -s ~/dotfiles/.vimperator ~/.vimperator
    elif [ ! -e ~/.vimperatorrc ]; then
        ln -s ~/dotfiles/.vimperatorrc ~/.vimperatorrc
    elif [ ! -e ~/.zshrc ]; then
        ln -s ~/dotfiles/.zshrc ~/.zshrc
    fi
else
    mkdir ~/dotfiles 
fi

if [ -e /usr/local/bin/brew ]; then
    if [ ! -e /usr/local/bin/htop ]; then
        brew install htop
    elif [ ! -e /usr/local/bin/rbenv ]; then
        brew install rbenv
    elif [ ! -e /usr/local/bin/fish ]; then
        brew install fish
    elif [ ! -e /usr/local/bin/tig ]; then
        brew install tig
    elif [ ! -e /usr/local/bin/git ]; then
        brew install git
    elif [ ! -e /usr/local/bin/vim ]; then
        brew install vim
        brew install tidy-html5
    elif [ ! -e /usr/local/bin/nodenv ]; then
        brew install nodenv
    elif [ ! -e /usr/local/bin/tmux ]; then
        brew install tmux
        brew install reattach-to-user-namespace
    fi
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
