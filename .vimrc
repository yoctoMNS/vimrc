"-----------------------------------------------------------------
" Plugin
"-----------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'uiiaoo/java-syntax.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'akhaku/vim-java-unused-imports'
    Plug 'cohama/lexima.vim'
    Plug 'tikhomirov/vim-glsl'
    Plug 'rebelot/kanagawa.nvim'
call plug#end()

"-----------------------------------------------------------------
" Startup
"-----------------------------------------------------------------
augroup MyAutoResize
  autocmd!
  autocmd VimEnter *.java :35split | wincmd j | :terminal
augroup END

highlight clear Bold
highlight clear bold

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
set noequalalways
set autoread
set updatetime=100
au CursorHold * checktime

"-----------------------------------------------------------------
" color scheme
"-----------------------------------------------------------------
" colorscheme  elflord
colorscheme  kanagawa

"-----------------------------------------------------------------
" appearance
"-----------------------------------------------------------------
" set cursorline
" set visualbell
set noshowmatch
set laststatus=2
set wildmode=list:longest
set nonumber
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE

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
inoremap <C-]> <C-[>:w<CR>
inoremap <C-[> <Esc>:w<CR>
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
" Build
nnoremap <F10> <C-w>j:!sh build.sh<CR>
" Run
nnoremap <F12> :!sh run.sh<CR>
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
nnoremap <Leader>gg :call GenerateJavaGetter()<CR>

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

" Javaファイル保存時に未使用のimportをハイライト表示
augroup JavaUnusedImports
  autocmd!
  autocmd BufWritePost *.java UnusedImports
augroup END

" 未使用のimportを削除
nnoremap <C-S-o> :UnusedImportsRemove<CR>

" 実際のクラスライブラリコードを閲覧する
nnoremap <F3> :!sh ~/openjdk_source.sh<CR>

" ペア文字の自動移動を設定
function! SkipPair()
  let line = getline('.')
  let col = col('.') - 1
  let next_char = line[col]
  let pair_list = ['[]', '()', "''", '""', '{}', '<>'] " 対象のペア文字

  for pair in pair_list
    let open = pair[0]
    let close = pair[1]
    if next_char == close
      return "\<Right>"
    endif
  endfor

  return "\<Tab>" " ペア文字でなければ通常のTAB動作
endfunction

" InsertモードでTABキーをオーバーライド
inoremap <expr> <Tab> SkipPair()

" Javaファイルで <C-c><C-c> を押すと自動で package と class を挿入する
augroup JavaClassInsert
  autocmd!
  autocmd FileType java nnoremap <buffer> <C-c><C-c> :call InsertJavaBoilerplate()<CR>
augroup END

function! InsertJavaBoilerplate()
  " カレントファイルのパスを取得
  let l:filepath = expand('%:p')
  let l:filename = expand('%:t:r')  " 拡張子なしのファイル名

  " src ディレクトリ以下を基準にしてパッケージを推測
  if l:filepath =~# 'src/'
    let l:relpath = substitute(l:filepath, '.*src/', '', '')
  else
    let l:relpath = substitute(l:filepath, getcwd().'/', '', '')
  endif

  " パッケージ名をディレクトリ構造から生成
  let l:packagedir = substitute(l:relpath, '/' . l:filename . '\.java$', '', '')
  let l:packagename = substitute(l:packagedir, '/', '.', 'g')

  " すべての 'main.java' を含む部分（ドット含む）を削除
  " 例: 'main.java.shaders' → 'shaders'
  let l:packagename = substitute(l:packagename, '\(.*\.\)\?main\.java\(\.\|$\)', '', 'g')

  " 末尾に余計なドットが残る場合はさらに除去
  let l:packagename = substitute(l:packagename, '^\.\+', '', '')
  let l:packagename = substitute(l:packagename, '\.\+$', '', '')

  " 空のパッケージ名は挿入しない
  if len(l:packagename) > 0
    call append(0, 'package ' . l:packagename . ';')
    call append(1, '')
    let l:startline = 2
  else
    let l:startline = 0
  endif

  " class 文を挿入
  call append(l:startline, 'public class ' . l:filename . ' {')
  call append(l:startline + 1, '')
  call append(l:startline + 2, '}')

  " カーソルを class の中に移動
  call cursor(l:startline + 2, 1)
endfunction

"-----------------------------------------------------------------
" FZF
"-----------------------------------------------------------------
nnoremap <Leader>f :Files<CR>
