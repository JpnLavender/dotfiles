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
[ -e ~/.config ]            || ln -s ~/dotfiles/.config ~/.config
[ -e ~/.tmux.conf ]         || ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
[ -e ~/.viminfo ]           || ln -s ~/dotfiles/.viminfo ~/.viminfo
[ -e ~/.vimperator ]        || ln -s ~/dotfiles/.vimperator ~/.vimperator
[ -e ~/.vimperatorrc ]      || ln -s ~/dotfiles/.vimperatorrc ~/.vimperatorrc
[ -e ~/.zshrc ]             || ln -s ~/dotfiles/.zshrc ~/.zshrc
[ -e  ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


case ${OSTYPE} in
    darwin*)
        if [ ! $(which brew) ]; then
            brew tap homebrew/brewdler
            brew brewdle
        else
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
        #fish install
        shell_path=`which fish`
        chsh -s $shell_path
        #ruby install
        rbenv install 2.3.1
        ;;
    linux*)
        #System install
        sudo su -
        curl http://fishshell.com/files/linux/RedHat_RHEL-5/fish.release:2.repo > /etc/yum.repos.d/shells:fish:release:2.repo #fish install Package
        yum install tig fish htop tmux vim
        shell_path=`which fish`
        chsh -s $shell_path
        #Ruby install 
        yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel libffi-devel libxml2 libxslt libxml2-devel libxslt-devel sqlite-devel
        git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
        cp -p /etc/profile /etc/profile.ORG
        diff /etc/profile /etc/profile.ORG
        echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile
        echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile
        echo 'eval "$(rbenv init -)"' >> /etc/profile
        source /etc/profile
        git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
        rbenv install 2.3.1
        ;;
esac
