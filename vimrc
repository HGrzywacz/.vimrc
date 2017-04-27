" General {{{
" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Fold this vimrc by categories
augroup vimrcFold
 autocmd!
 autocmd FileType vim set foldmethod=marker
 autocmd FileType vim set foldlevel=0
augroup END

" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

" }}}

" Plugins: vim-plug, pathogen {{{
" documentation: https://github.com/junegunn/vim-plug
" to install run $ vim +PlugInstall +qall
" to update all plugins run $ vim +PlugUpdate +qall

set nocompatible

call plug#begin('~/.vim/bundle')

" Movement, shortcuts
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'
Plug 'ervandew/supertab'
Plug 'bkad/CamelCaseMotion'
Plug 'Yggdroot/indentLine'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'glts/vim-textobj-indblock'
Plug 'kana/vim-textobj-indent'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/utl.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'tpope/vim-speeddating'

" Tools, modes, searching, navigation
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neocomplete.vim'
Plug 'bling/vim-airline'
Plug 'junegunn/vim-peekaboo'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'rhysd/devdocs.vim'
Plug 'junegunn/goyo.vim'
Plug 'moll/vim-bbye'

" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Colors, visuals
Plug 'nice/sweater'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/unicode.vim'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kshenoy/vim-signature'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Org mode
Plug 'jceb/vim-orgmode'

" Language-specific plugins

"   CoffeeScript
Plug 'kchmck/vim-coffee-script', {'for': 'coffeescript'}

"   JavaScript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'walm/jshint.vim', {'for': 'javascript'}
Plug 'marijnh/tern_for_vim', {'for': 'javascript'}

"   Scala
Plug 'derekwyatt/vim-scala', {'for': 'scala'}

"   Clojure
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

"   HTML
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'othree/html5.vim', {'for': 'html'}

"   Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }

" Python
Plug 'ehamberg/vim-cute-python'

call plug#end()

call pathogen#infect()
syntax enable
filetype plugin indent on

" }}}

" Fonts {{{

" Rainbow parentheses
augroup rainbow
  autocmd!
  autocmd VimEnter * RainbowParentheses
augroup END

" }}}

" Colors {{{

set t_Co=256
colorscheme PaperColor

" let g:solarized_termcolors=256
" colorscheme twilight
" syntax enable
" set background=dark
" colorscheme solarized

" airline theme
let g:airline_theme='papercolor'
" always show airline
set laststatus=2

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"

" }}}

" User Interface {{{

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Easy moving between splits
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
let mapleader = "\<Space>"

" <Space>w to save
nnoremap <Leader>w :w<CR>

" <Space><Space> to enter visual line mode
nmap <Leader><Leader> V

" Autoresize split
function! Autoresize()
  :exec "resize " . (line("$") + 1)
  :call feedkeys("zb")
endfunction

command! AR call Autoresize()

" Make buffer read-only
function! LockBuffer()
  :exec "set nomodifiable"
endfunction

function! UnlockBuffer()
  :exec "set modifiable"
endfunction

command! Lock call LockBuffer()
command! Unlock call UnlockBuffer()

" via: http://stackoverflow.com/a/3102890
" improved by me
function! ScrollToPercent(percent)
    let movelines= winheight(0) * (50-a:percent)/100
    if movelines<0
        let motion='j'
        let rmotion='k'
        let movelines=-movelines
    elseif movelines>0
        let motion='k'
        let rmotion='j'
    else
        return 0
    endif
    if has('float') && type(movelines)==type(0.0)
        let movelines=float2nr(movelines)
    endif
    execute 'normal! zt'.movelines.motion.'zt'.movelines.rmotion
endfunction

nnoremap zx :<C-u>call ScrollToPercent(25)<CR>
nnoremap <Leader>z :<C-u>call ScrollToPercent(25)<CR>

" 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Stay in visual mode when indenting. To not have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" }}}

" History {{{

" Persistent undo
if exists("&undodir")
    set undofile          "Persistent undo! Pure money.
    let &undodir=&directory
    set undolevels=500
    set undoreload=500
endif

" Gundo
nnoremap <F5> :GundoToggle<CR>

" }}}

" Searching and indentation {{{

" Searching
set ignorecase
set smartcase

" Use pleasant but very visible search hilighting (from haskell-vim-now)
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" Indentation
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cinkeys=0{,0},:,0#,!^F
set ff=unix

" turn on relative numbering
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif

  if(&number == 1)
    set nonumber
  else
    set number
  endif
endfunc

nnoremap <Leader>n :call NumberToggle()<cr>
command! LN call NumberToggle()

" Open new vertical splits on the right side
set splitright

" Yggdroot/indentLine
let g:indentLine_enabled = 0

" }}}

" Registers - preview, shortcuts {{{

" 'junegunn/vim-peekaboo'
" Default peekaboo window
let g:peekaboo_window = 'vertical botright 30new'

" Delay opening of peekaboo window (in ms. default: 0)
let g:peekaboo_delay = 800

" Copy default register @" to @k and save old value of @k in @j
" via: http://vim.wikia.com/wiki/Comfortable_handling_of_registers
nnoremap <silent> <Leader>s :let @j=@k \| let @k=@"<CR>

" }}}

" Buffers - deleting {{{
"
" http://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

command! Bd call DeleteHiddenBuffers()

" }}}

" CtrlP {{{

" CtrlP
" keep cache after exiting vim
let g:ctrlp_clear_cache_on_exit = 1

nnoremap <silent> <Leader>p :CtrlPBuffer<CR>
set hidden

" ignore files in .gitignore
" via: http://stackoverflow.com/a/26729140
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]

" }}}

" QuickReference and QuickSnipsReference {{{

function! OpenQuickReference()
  vs|view ~/.vim/quickreference.txt
  set ft=help
endfunction

command! QR call OpenQuickReference()
command! H call OpenQuickReference()

function! OpenQuickSnipReference(lang)
  if a:lang ==# "Haskell"
    vs|view ~/.vim/bundle/vim-snippets/snippets/haskell.snippets
    set ft=snippets
  elseif a:lang ==# "CoffeeScript"
    vs|view ~/.vim/bundle/vim-snippets/snippets/coffee/coffee.snippets
    set ft=snippets
  elseif a:lang ==# "AngularCoffee"
    vs|view ~/.vim/bundle/vim-snippets/snippets/coffee/angular_coffee.snippets
    set ft=snippets
  elseif a:lang ==# "JavaScript"
    vs|view ~/.vim/bundle/vim-snippets/snippets/javascript/javascript.snippets
    set ft=snippets
  endif
endfunction

command! SnipsHaskell call OpenQuickSnipReference("Haskell")
command! SnipsCoffee call OpenQuickSnipReference("CoffeeScript")
command! SnipsAngularCoffee call OpenQuickSnipReference("AngularCoffee")
command! SnipsJS call OpenQuickSnipReference("JavaScript")

function! OpenAutoSnip()
  let l:filetype = &filetype

    if l:filetype ==# "haskell"
      call OpenQuickSnipReference("Haskell")
    elseif l:filetype ==# "coffee"
      vs|view ~/.vim/bundle/vim-snippets/snippets/coffee/coffee.snippets
      set ft=snippets
    elseif l:filetype ==# "javascript"
      vs|view ~/.vim/bundle/vim-snippets/snippets/javascript/javascript.snippets
      set ft=snippets
    endif
endfunction

command! Snips call OpenAutoSnip()

" }}}

" Spell checking and abbreviations {{{

" Pressing <Space>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

abbr heigth height
abbr widht width
abbr lenght length

" }}}

" Narrow Region {{{

" Open narrowed region in vertical split buffer
let g:nrrw_rgn_vert = 1

" Default width for scratch buffer
let g:nrrw_rgn_wdth = 112

" }}}

" UltiSnips {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" }}}

" Git {{{

" disable gitgutter by default
let g:gitgutter_enabled = 0
nnoremap <Leader>g :GitGutterToggle<CR>

" }}}

" Goyo {{{

" 'junegunn/goyo.vim'
let g:goyo_width = 110
let g:goyo_margin_top = -1
let g:goyo_margin_bottom = -1
let g:goyo_linenr = 0

" }}}

" HTML {{{

" Tidy - tidy html and reload filea
fun! Tidy()

  execute "! tidy -mi -xml -config ~/.vimrc/tidyrc " . bufname("%")
  e

endfunction

command! Tidy call Tidy()

" emmet-vim options
let g:user_emmet_settings = {'indentation' : '  '}

autocmd FileType html setlocal indentkeys-=*<Return>

" }}}

" JavaScript {{{

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

" }}}

" CoffeeScript {{{

" Find .coffeelintrc.json file
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

" CoffeeScript linter
let g:coffee_lint_options = ''

fun! CoffeeLint()

  let g:coffee_lint_options = FindCoffeeLintConfig()

  CoffeeLint

  if (len(getqflist()) == 0)
    echo "CoffeeLint: no warnings"
    cclose
  else
    cw
  endif

endfunction

" CoffeeLint
command! CSLint call CoffeeLint()
command! CL call CoffeeLint()

" CoffeeCompile
command! -range=% CC <line1>,<line2> CoffeeCompile
command! -range=% CV <line1>,<line2> CoffeeCompile vert

" Turn off 'intelligent'/'automatic' intendation
command! Noauto setl noai nocin nosi inde=

" CoffeeWatch
command! CW CoffeeWatch
command! CWV CoffeeWatch vert

" 'jeetsukumaran/vim-indentwise' mappings for coffeScript
autocmd FileType coffee map <buffer> { <Plug>(IndentWisePreviousLesserIndent)
autocmd FileType coffee map <buffer> } <Plug>(IndentWiseNextEqualIndent)

"}}}

" XML {{{

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
filetype indent on
highlight RedundantSpaces ctermbg=4 guibg=red
match RedundantSpaces /\s\+\%#\@!$\| \+\ze\t/

" }}}

" SML {{{

" vim-commentary comment string for SML
autocmd FileType sml set commentstring=(*%s*)

" }}}

" Haskell {{{

let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" Pretty unicode haskell symbols
" let g:haskell_conceal_wide = 1
" let g:haskell_conceal_enumerations = 1
" let hscoptions="Al𝐒𝐓𝐄𝐌xRtB𝔻w"

" augroup clearconceal
"   autocmd!
"   autocmd VimEnter * hi clear Conceal
" augroup END

" " Use same color behind concealed unicode characters
" hi clear Conceal
set cole=0
au FileType * setl cole=0

" }}}

" Lilypond {{{
filetype off
set runtimepath+=/usr/share/lilypond/current/vim
filetype on
syntax on

augroup filetypedetect
    au BufRead,BufNewFile *.lytex setfiletype tex
augroup END

"}}}

" Automation on writing to file {{{

" Remove trailing whitespaces and empty lines on the end of the file
function! RemoveEmptyAndWhite()
  :%s/\s\+$//e
  :%s#\($\n\s*\)\+\%$##e
endfunction

command! Clean call RemoveEmptyAndWhite()
autocmd BufWritePre * call RemoveEmptyAndWhite()

" Turn off Scratch, Preview window of autocompletion
set completeopt-=preview

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

"}}}

" neocomplete {{{
" https://github.com/Shougo/neocomplete.vim
let g:neocomplete#enable_at_startup = 1
"}}}

" pairify {{{
" https://www.reddit.com/r/vim/comments/5ws9tg/does_vim_have_a_plugin_using_tab_to_close_and_get/decygam/

if exists('g:loaded_pairify')
  finish
endif
let g:loaded_pairify = 1

let g:pairs = {
      \ "left": {
      \   "[": "]",
      \   "(": ")",
      \   "{": "}",
      \   "<": ">",
      \   "'": "'",
      \   '"': '"'
      \ },
      \ "right": {
      \   "]": "[",
      \   ")": "(",
      \   "}": "{",
      \   ">": "<",
      \   "'": "'",
      \   '"': '"'
      \ }
      \}

function! s:is_compliment(char1, char2)
  if has_key(g:pairs.left, a:char1)
    return a:char2 == g:pairs.left[a:char1]
  elseif has_key(g:pairs.right, a:char1)
    return a:char2 == g:pairs.right[a:char1]
  endif
endfunction

function! s:is_quote(char)
  return a:char ==# "'" || a:char ==# '"'
endfunction

function! s:find_pair(string)
  let stack = []
  let characters = split(a:string, '\zs')

  for char in reverse(characters)
    if has_key(g:pairs.right, char)
      if !empty(stack) && s:is_quote(char) && stack[-1] ==# char
        call remove(stack, -1)
        continue
      endif
      call add(stack, char)
    elseif has_key(g:pairs.left, char)
      if !empty(stack) && s:is_compliment(char, stack[-1])
        call remove(stack, -1)
      elseif empty(stack)
        return g:pairs.left[char]
      endif
    endif
  endfor

  if empty(stack)
    return "\t"
  else
    return remove(stack, 0)
  endif
endfunction

function! s:pairify()
  return s:find_pair(getline('.')[0:col('.')-1])
endfunction

inoremap <expr> <silent> <Plug>(pairify-complete) <SID>pairify()
imap <C-c> <Plug>(pairify-complete)

" }}}
