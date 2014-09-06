.vimrc - cloning guide
======
-------------------------------

1. Clone the repository

        $ git clone https://github.com/HGrzywacz/.vimrc.git ~/.vim
        $ ln -s ~/.vim/vimrc ~/.vimrc

2. Set up [Vundle]:

        $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bndule/Vundle.vim

3. Set up [Pathogen]:

        $ mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        $ curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

4. Install plugins:

        $ vim +PluginInstall +qall

5. Compile YCM:

        $ cd ~/.vim/bundle/YouCompleteMe
        $ ./install.sh

6. Install the tern server:
        $ cd  ~/.vim/bundle/tern_for_vim
        $ npm install

[Vundle]:http://github.com/gmarik/Vundle.vim
[Pathogen]:https://github.com/tpope/vim-pathogen
