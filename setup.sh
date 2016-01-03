#! /usr/bin/env sh

ln -s ~/.vim/vimrc ~/.vimrc

# Set up vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set up Pathogen:
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install plugins:
vim +PlugInstall +qall

# Complile YCM:
cd ~/.vim/bundle/YouCompleteMe
./install.sh

# Install the tern server:
cd  ~/.vim/bundle/tern_for_vim
npm install

# Go to home folder
cd
