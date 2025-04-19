"-----------------------------------------------------------------
" Encoding
"-----------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'uiiaoo/java-syntax.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

"-----------------------------------------------------------------
" Encoding
"-----------------------------------------------------------------
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
nnoremap <Esc><Esc> :nohlsearch<Return>
inoremap ;lkj <Esc>:w<CR>
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
nnoremap <C-n><C-f> :lcd %:h<Return>
nnoremap <C-n><C-s> :e ~/workspace/git/vimrc/.vimrc<Return>
nnoremap <A-j> Vdp
nnoremap <A-k> VdkP
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"-----------------------------------------------------------------
" java
"-----------------------------------------------------------------
inoremap <C-c><C-v> <Esc>bvey$pa;<Esc>bvu$a
" Java Insert Class Snippet
nnoremap <C-c><C-c> i<C-r>=expand('%:r')<Return><Esc>T/hv^dIpublic<Space>class<Space><Esc>$a<Space>{<Return>}<Esc>gg$a<Return>
" Java Insert Package Snippet
inoremap <C-c><C-u> i<C-r>=expand('%:r')<Return><Esc>^vt/ld$vbhdV:s/\//\./g<Return>
" Java Override
inoremap <C-c><C-o> @Override<Return>
" Java Import Snippet
inoremap <C-c><C-i> import<Space>;<Left>
" Java Implements
inoremap <C-c><C-p> implements<Space>
" Java Extends
inoremap <C-c><C-n> extends<Space>
" Java System.out.print
inoremap <C-c><C-j> System.out.print();<Left><left>
" Java System.out.println
inoremap <C-c><C-k> System.out.println();<Left><left>
" Java System.out.printf
inoremap <C-c><C-l> System.out.printf();<Left><left>
" Java Main Method Snippet
inoremap <C-c><C-m> public<Space>static<Space>void<Space>main(String[]<Space>args)<Space>{<Return>}<Esc>k$a<Return>
" Java Implements Abstract Method
nnoremap <C-r><C-r> G%jVG:s/public/@Override\r\tpublic/g<Return><Esc>G%jVG:s/abstract //g<Return>G%jVG:s/;/<Space>{\r\t}\r/g<Return>
" Java Implements Interface Method
vnoremap <C-r><C-i> :s/;/<Space>{\r\t}\r/g<Return>
" Java Add Override Annotations
vnoremap <C-r><C-o> :s/public/@Override\r\tpublic/g<Return>
" Java Getter
function! GenerateJavaGetter()
    " 現在行の解析
    let current_line = getline('.')
    let pattern = '^\s*\(\(public\|protected\|private\)\s\+\)\?\(\(static\|final\)\s\+\)*\([a-zA-Z_][a-zA-Z0-9_<>\[\]]*\)\s\+\([a-zA-Z_][a-zA-Z0-9_]*\)\s*\(=\s*[^;]*\)\?\s*;\s*$'
    let matches = matchlist(current_line, pattern)

    if empty(matches)
        echo "Error: Not a Java member variable line!"
        return
    endif

    " ゲッター生成
    let type = matches[5]
    let var_name = matches[6]
    let getter_name = "get" . toupper(var_name[0]) . var_name[1:]
    let getter = [
        \ "",
        \ "    public " . type . " " . getter_name . "() {",
        \ "        return " . var_name . ";",
        \ "    }"
        \ ]

    " クラスの終わりを正確に検出（最後の閉じ括弧の前）
    let class_end_line = search('^\s*}', 'bnW')
    if class_end_line == 0
        let class_end_line = line('$') " ファイル末尾をフォールバック
    endif

    " 既存メソッドとの間に行挿入
    call append(class_end_line - 1, getter)
    echo "Generated: " . getter_name . "()"
endfunction
nnoremap <Leader>gj :call GenerateJavaGetter()<CR>

" Java Setter
function! GenerateJavaSetter()
    " 現在行の解析
    let current_line = getline('.')
    let pattern = '^\s*\(\(public\|protected\|private\)\s\+\)\?\(\(static\|final\)\s\+\)*\([a-zA-Z_][a-zA-Z0-9_<>\[\]]*\)\s\+\([a-zA-Z_][a-zA-Z0-9_]*\)\s*;'
    let matches = matchlist(current_line, pattern)

    if empty(matches)
        echo "Error: Not a Java member variable line!"
        return
    endif

    " セッター生成
    let type = matches[5]
    let var_name = matches[6]
    let setter_name = "set" . toupper(var_name[0]) . var_name[1:]
    let setter = [
        \ "",
        \ "    public void " . setter_name . "(" . type . " " . var_name . ") {",
        \ "        this." . var_name . " = " . var_name . ";",
        \ "    }"
        \ ]

    " クラスの終わりを正確に検出（最後の閉じ括弧の前）
    let class_end_line = search('^\s*}', 'bnW')
    if class_end_line == 0
        let class_end_line = line('$') " ファイル末尾をフォールバック
    endif

    " 既存メソッドとの間に行挿入
    call append(class_end_line - 1, setter)
    echo "Generated: " . setter_name . "()"
endfunction

nnoremap <Leader>gs :call GenerateJavaSetter()<CR>

" Java Getter Setter
function! GenerateJavaGetterSetter()
    " 現在行の解析
    let current_line = getline('.')
    let pattern = '^\s*\(\(public\|protected\|private\)\s\+\)\?\(\(static\|final\)\s\+\)*\([a-zA-Z_][a-zA-Z0-9_<>\[\]]*\)\s\+\([a-zA-Z_][a-zA-Z0-9_]*\)\s*;'
    let matches = matchlist(current_line, pattern)

    if empty(matches)
        echo "Error: Not a Java member variable line!"
        return
    endif

    " 変数名と型を取得
    let type = matches[5]
    let var_name = matches[6]

    " メソッド名作成
    let capitalized = toupper(var_name[0]) . var_name[1:]
    let getter_name = "get" . capitalized
    let setter_name = "set" . capitalized

    " ゲッター
    let getter = [
        \ "",
        \ "    public " . type . " " . getter_name . "() {",
        \ "        return " . var_name . ";",
        \ "    }"
        \ ]

    " セッター
    let setter = [
        \ "",
        \ "    public void " . setter_name . "(" . type . " " . var_name . ") {",
        \ "        this." . var_name . " = " . var_name . ";",
        \ "    }"
        \ ]

    " 両方まとめて
    let methods = getter + setter

    " クラスの終わりを検出（最後の } の前）
    let class_end_line = search('^\s*}', 'bnW')
    if class_end_line == 0
        let class_end_line = line('$') " ファイル末尾をフォールバック
    endif

    " 2行前に挿入
    call append(class_end_line - 1, methods)
    echo "Generated: " . getter_name . "() and " . setter_name . "()"
endfunction

nnoremap <Leader>gd :call GenerateJavaGetterSetter()<CR>

"-----------------------------------------------------------------
" FZF
"-----------------------------------------------------------------
nnoremap <Leader>f :Files<CR>
