"-----------------------------------------------------------------
" Plugin
"-----------------------------------------------------------------
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'},
    Plug 'scrooloose/syntastic',
    Plug 'fatih/vim-go',
    Plug 'vim-scripts/java_getset.vim',
    Plug 'yegappan/mru',
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim',
call plug#end()

"-----------------------------------------------------------------
" color scheme
"-----------------------------------------------------------------
colorscheme torte
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
set dictionary=~/.vim/dict/java_all_classes.dict
set clipboard+=unnamed

"-----------------------------------------------------------------
" appearance
"-----------------------------------------------------------------
set number
set cursorline
" set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set nonumber

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
nnoremap <C-S-h> <C-w><
nnoremap <C-S-j> <C-w>+
nnoremap <C-S-k> <C-w>-
nnoremap <C-S-l> <C-w>>
noremap ; :
nnoremap <C-n><C-t> :Ntree<Return>
nnoremap <C-n><C-j> :lcd ~/Documents/jdk-21<Return>:Files<Return>
nnoremap <C-n><C-f> :lcd %:h<Return>
nnoremap <C-n><C-s> :e ~/.vimrc<Return>
inoremap <C-c><C-v> <Esc>bvey$pa;<Esc>bvu$a
nnoremap <A-j> Vdp
nnoremap <A-k> VdkP
inoremap <C-d> <C-x><C-k>
nnoremap <C-m><C-r> :MRU<Return>
inoremap <C-Space> <C-x><C-o>
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap \" \"\"<LEFT>
" inoremap ' ''<LEFT>

"-----------------------------------------------------------------
" java
"-----------------------------------------------------------------
" filetype plugin indent on
" set backspace=indent,eol,start
" set omnifunc=syntaxcomplete#Complete
" set suffixesadd=.java
" set showcmd
" autocmd Filetype java set makeprg=./build.sh
" set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
" nnoremap <F9> :make<Return>:copen<Return>
" nnoremap <F10> :cprevious<Return>
" nnoremap <F11> :cnext<Return>
" nnoremap <C-S-i> :JIG<Return>
" nnoremap <C-S-o> :JI<Return>:JIS<Return>G%k$a<Return><Esc>
" nnoremap <F3> :JIF<Return>
" "Java Getter"
" nnoremap gg hv^wyGOpublic <Esc>pvbyvUiget<Esc>$a() {<Return>return <Esc>pa;<Return>}<Return><Esc>
" "Java Setter"
" nnoremap gs hv^wyGOpublic void set(<Esc>pa) {<Esc>bbvey^wwwPblllvU$a<Return>this.<Esc>pa = <Esc>pa;<Return>}<Return><Esc>
" "Java Getter & Setter"
" nnoremap gd hv^wyGOpublic void set(<Esc>pa) {<Esc>bbvey^wwwPblllvU$a<Return>this.<Esc>pa = <Esc>pa;<Return>}<Return><Esc>3k$T(vt)yGOpublic <Esc>pvbyvUiget<Esc>$a() {<Return>return <Esc>pa;<Return>}<Return><Esc>
" "Java Insert Class Snippet"
" nnoremap <C-c><C-c> i<C-r>=expand('%:r')<Return><Esc>T/hv^dIpublic<Space>class<Space><Esc>$a<Space>{<Return>}<Esc>gg$a<Return>
" "Java Insert Package Snippet"
" inoremap <C-c><C-u> i<C-r>=expand('%:r')<Return><Esc>^vt/ld$vbhdV:s/\//\./g<Return>
" " Ipackage<Space><Esc>$a;<Return><Esc>
" "Java Override"
" inoremap <C-c><C-o> @Override<Return>
" "Java Import Snippet"
" inoremap <C-c><C-i> import<Space>;<Left>
" "Java Implements"
" inoremap <C-c><C-p> implements<Space>
" "Java Extends"
" inoremap <C-c><C-n> extends<Space>
" "Java System.out.print"
" inoremap <C-c><C-j> System.out.print();<Left><left>
" "Java System.out.println"
" inoremap <C-c><C-k> System.out.println();<Left><left>
" "Java System.out.printf"
" inoremap <C-c><C-l> System.out.printf();<Left><left>
" "Java Main Method Snippet"
" inoremap <C-c><C-m> public<Space>static<Space>void<Space>main(String[]<Space>args)<Space>{<Return>}<Esc>k$a<Return>
" "Java Implements Abstract Method"
" nnoremap <C-r><C-r> G%jVG:s/public/@Override\r\tpublic/g<Return><Esc>G%jVG:s/abstract //g<Return>G%jVG:s/;/<Space>{\r\t}\r/g<Return>
" "Java Implements Interface Method"
" vnoremap <C-r><C-i> :s/;/<Space>{\r\t}\r/g<Return>
" "Java Add Override Annotations"
" vnoremap <C-r><C-o> :s/public/@Override\r\tpublic/g<Return>

"-----------------------------------------------------------------
" javaid.vim
"-----------------------------------------------------------------
set sm
set ai
:let java_highlight_all=1
:let java_allow_cpp_keywords=1
:let java_highlight_debug=1
:let java_space_errors=1
:let java_highlight_functions=1

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

"-----------------------------------------------------------------
" mru.vim
"-----------------------------------------------------------------
:let MRU_Max_Entries=20

"-----------------------------------------------------------------
" vim-go
"-----------------------------------------------------------------
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []
let g:go_jump_to_error = 0
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_disable_autoinstall = 0
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"

"-----------------------------------------------------------------
" coc-vim
"-----------------------------------------------------------------
nnoremap <silent> <F1> <Plug>(coc-definition)
nnoremap <silent> <F2> <Plug>(coc-rename)
nnoremap <silent> <F3> <Plug>(coc-definition)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
