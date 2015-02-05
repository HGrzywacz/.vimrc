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

Bundle 'pangloss/vim-javascript'

Bundle 'derekwyatt/vim-scala'

Plugin 'guns/vim-clojure-static'

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'nice/sweater'

Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-endwise'

Plugin 'tpope/vim-fugitive'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'mattn/emmet-vim'

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

nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-j> <c-w>j

map <silent> <S-Up> <C-y>
map <silent> <S-Down> <C-e>

" mapleader
" <Space>w to save
" <Space><Space> to enter visual line mode
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V

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

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Turn off Scratch, Preview window of autocompletion
set completeopt-=preview

colorscheme twilight

" Automatically close vim if quickfix window is the last
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit
    endif
  endif
endfunction

" find .coffeelintrc.json file
fun! FindCoffeeLintConfig()"
  let currentDir = expand("%:p:h") . "/"
  let filename = ".coffeelintrc.json"

  let path = currentDir . filename

  while !filereadable(expand(path))
    if (len(currentDir) == 0)
      return ''
    endif

    let currentDir = "/" . join(split(currentDir, "/")[0:-2], "/") . "/"
    let path = currentDir . filename
  endwhile

  return "-f " . path
endfunction

" My own jslinter
fun! JSLint() "{{{

  let l:winview = winsaveview()

  %s/\(if\|for\|while\)(/\1 (/ge              "space after if,for,while
  %s/else{/else {/ge                          "space after else
  %s/}else/} else/ge                          "space before else
  %s/\(,\|:\)\(\w\)/\1 \2/ge                  "space after ,|:
  %s/){/) {/ge                                "space between ) {
  %s/function(/function (/ge                  "space after function
  " %s/\(\w\|d\|\'\|\"\)\(+\|-\|=\)/\1 \2/ge     "space before operator +|-|=|==

  call winrestview(l:winview)

endfunction "}}}

command! JSLint call JSLint()

let g:coffee_lint_options = ''

" CoffeeScript linter
fun! CoffeeLint() "{{{

  let g:coffee_lint_options = FindCoffeeLintConfig()

  CoffeeLint

  if (len(getqflist()) == 0)
    echo "CoffeeLint: no warnings"
    cclose
  else
    cw
  endif

endfunction "}}}

command! CSLint call CoffeeLint()
command! CL call CoffeeLint()

" CoffeeCompile
command! -range=% CC <line1>,<line2> CoffeeCompile
command! -range=% CV <line1>,<line2> CoffeeCompile vert

let g:user_emmet_settings = {'indentation' : '  '}
