.vimrc - cloning guide
======
-------------------------------

1. Clone the repository

        $ git clone https://github.com/HGrzywacz/.vimrc.git ~/.vim
        $ ln -s ~/.vim/vimrc ~/.vimrc

2. Run `~/.vimrc/setup.sh` or:

2. Set up [vim-plug]:

        $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

3. Set up [Pathogen]:

        $ mkdir -p ~/.vim/autoload ~/.vim/bundle
        $ curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

4. Install plugins:

        $ vim +PluginInstall +qall

5. Install the tern server:

        $ cd  ~/.vim/bundle/tern_for_vim
        $ npm install

6. Install [tidy]:

        $ sudo apt-get install tidy

7. [optional] Install [CoffeeLint]:

        $ npm install -g coffeelint

[vim-plug]:https://github.com/junegunn/vim-plug
[Pathogen]:https://github.com/tpope/vim-pathogen
[CoffeeLint]:http://www.coffeelint.org/
[tidy]:http://tidy.sourceforge.net/
