#! /bin/bash
[ -e ~/.vimrc ] || ln -s ~/dotfiles/.vimrc ~/.vimrc
if [ ! -e ~/.vim ]; then
    ln -s ~/dotfiles/.vim ~
    ln -s ~/dotfiles/.vim/colors/solarized.vim ~/.vim/colors
    files=( basic bundle color indent key path plugin theme )
    for file in ${files[@]}; do
        ln -s ~/dotfiles/.vim/.vimrc.$file ~/.vim/.vimrc.$file
    done
fi
[ -e ~/.config ]       || ln -s ~/dotfiles/.config ~/.config
[ -e ~/.tmux.conf ]    || ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
[ -e ~/.viminfo ]      || ln -s ~/dotfiles/.viminfo ~/.viminfo
[ -e ~/.vimperator ]   || ln -s ~/dotfiles/.vimperator ~/.vimperator
[ -e ~/.vimperatorrc ] || ln -s ~/dotfiles/.vimperatorrc ~/.vimperatorrc
[ -e ~/.zshrc ]        || ln -s ~/dotfiles/.zshrc ~/.zshrc

if [ ! $(which brew) ]; then
    brew tap homebrew/brewdler
    brew brewdle
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
