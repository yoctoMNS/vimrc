"-----------------------------------------------------------------
" Plugin
"-----------------------------------------------------------------
call plug#begin()
    Plug 'repository/vim-plug_plugin.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

"-----------------------------------------------------------------
" color scheme
"-----------------------------------------------------------------
colorscheme koehler
" colorscheme desert

"-----------------------------------------------------------------
" font
"-----------------------------------------------------------------
" Encoding=====================
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set fileencodings=utf-8,euc-jp,sjis

"-----------------------------------------------------------------
" System
"-----------------------------------------------------------------
set nobackup
set noswapfile
set autoread
set viminfo=
set noundofile
set hidden
set noshowcmd
set cindent
set iminsert=0
set imsearch=-1
set guicursor=a:blinkon0
syntax on
set nowrap
set guioptions-=T
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set statusline=%f%{'['.(&fenc!=''?&fenc:&enc).'-'.&ff.']'}\ \0\x%B%=%l,%c%V%8P

"-----------------------------------------------------------------
" appearance
"-----------------------------------------------------------------
set number
" set cursorline
" set visualbell
set showmatch
set laststatus=0
set wildmode=list:longest

"-----------------------------------------------------------------
" Tab
"-----------------------------------------------------------------
set expandtab
set tabstop=4
set shiftwidth=4

"-----------------------------------------------------------------
" search
"-----------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

"-----------------------------------------------------------------
" key mapping
"-----------------------------------------------------------------
nmap <Esc><Esc> :nohlsearch<Return>
inoremap <C-]> <Esc>

nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap <Space>l $
nnoremap <Space>h ^
nnoremap <Space>k gg
nnoremap <Space>j G

noremap ; :

nnoremap <C-n><C-t> :Ntree<Return>
nnoremap <C-n><C-j> :lcd ~/Documents/jdk-21<Return>:Files<Return>
nnoremap <C-n><C-f> :lcd %:h<Return>

nnoremap <C-n><C-s> :e ~/.vimrc<Return>
inoremap <C-c><C-v> <Esc>bvey$pa;<Esc>bvu$a
inoremap <C-c><C-o> @Override<Return>
inoremap <C-c><C-i> import<Space>;<Left>
inoremap <C-c><C-p> implements<Space>
inoremap <C-c><C-n> extends<Space>
inoremap <C-c><C-j> System.out.print();<Left><left>
inoremap <C-c><C-k> System.out.println();<Left><left>
inoremap <C-c><C-l> System.out.printf();<Left><left>

"-----------------------------------------------------------------
" javaid.vim
"-----------------------------------------------------------------
set sm
set ai
:let java_highlight_all=1
:let java_highlight_functions="style"
:let java_allow_cpp_keywords=1

"-----------------------------------------------------------------
" buffer
"-----------------------------------------------------------------
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"-----------------------------------------------------------------
" transparencey
"-----------------------------------------------------------------
" autocmd FocusGained * set transparency=200
" autocmd FocusLost * set transparency=150

"-----------------------------------------------------------------
" fzf.vim
"-----------------------------------------------------------------
nnoremap <Space>f :Files<CR>
