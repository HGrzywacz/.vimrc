" documentation: https://github.com/gmarik/Vundle.vim#about
" to install run $ vim +PluginInstall +qall

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle include and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

Plugin 'gmarik/Vundle.vim'

" https://github.com/Valloric/YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" https://github.com/marijnh/tern_for_vim
Plugin 'marijnh/tern_for_vim'

Plugin 'kchmck/vim-coffee-script'

" Supported plugins formats
" - plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" - plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" - Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" - git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" - The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" - Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"
call vundle#end()
filetype plugin indent on

" easy moving between splits
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

map <silent> <S-Up> <C-y>
map <silent> <S-Down> <C-e>

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cinkeys=0{,0},:,0#,!^F
set ff=unix

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
filetype indent on
highlight RedundantSpaces ctermbg=4 guibg=red
match RedundantSpaces /\s\+\%#\@!$\| \+\ze\t/

autocmd BufWritePre * :%s/\s\+$//e

call pathogen#infect()
syntax enable
filetype plugin indent on
