#! /usr/bin/env sh

ln -s ~/.vim/vimrc ~/.vimrc

# Set up Vundle:
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up Pathogen:
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install plugins:
vim +PluginInstall +qall

# Complile YCM:
cd ~/.vim/bundle/YouCompleteMe
./install.sh

# Install the tern server:
cd  ~/.vim/bundle/tern_for_vim
npm install

# Go to home folder
cd
