#! /bin/bash

#------------------ link configfiles ------------------
[ -e ~/.vimrc ] || ln -fs ~/dotfiles/.vimrc ~/.vimrc
if [ ! -e ~/.vim ]; then
    ln -s ~/dotfiles/.vim ~
    ln -s ~/dotfiles/.vim/colors/solarized.vim ~/.vim/colors
    files=( basic bundle color indent key path plugin theme )
    for file in ${files[@]}; do
        ln -s ~/dotfiles/.vim/.vimrc.$file ~/.vim/.vimrc.$file
    done
fi

[ -e ~/.zshrc ] || ln -fs ~/dotfiles/.zshrc ~/.zshrc
if [ ! -e ~/.zsh ]; then
    ln -s ~/dotfiles/.zsh ~
    files=( alias basic export function )
    for file in ${files[@]}; do
        ln -fs ~/dotfiles/.zsh/$file.zsh ~/.zsh/$file.zsh
    done
fi

[ -e  ~/.tmux-powerline ]                      || git clone https://github.com/erikw/tmux-powerline.git ~/tmux-powerline
[ -e  ~/.tmux/plugins/tpm ]                    || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -rf ~/tmux-powerline/themes/default.sh
[ -e ~/.tmux.conf ]                            || ln -fs ~/dotfiles/.tmux.conf ~/.tmux.conf
[ -e ~/.vimperator ]                           || ln -fs ~/dotfiles/.vimperator ~/.vimperator
[ -e ~/.vimperatorrc ]                         || ln -fs ~/dotfiles/.vimperatorrc ~/.vimperatorrc
[ -e ~/tmux-powerline/themes/default.sh ]      || ln -fs ~/dotfiles/default.sh ~/tmux-powerline/themes/default.sh


#------------------ install for oh-my-zsh ------------------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#------------------ install for packages ------------------
case ${OSTYPE} in
    darwin*)
        if [ ! $(which brew) ]; then
            brew tap homebrew/brewdler
            brew bundle
        else
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap homebrew/brewdler
            brew brewdle
        fi
        shell_path=`which zsh`
        chsh -s $shell_path
        ;;
    linux*)
        sudo yum install -y tig fish htop tmux vim zsh
        shell_path=`which zsh`
        sudo chsh -s $shell_path
        ;;
esac
