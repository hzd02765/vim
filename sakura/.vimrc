scriptencoding utf-8
set nocompatible

"-------------------------------------------------------------------------------
"exampleから
"-------------------------------------------------------------------------------
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
  " set mouse=a
" endif

"-------------------------------------------------------------------------------
" pathogen
"-------------------------------------------------------------------------------
execute pathogen#infect()
" .vim/bunle/plugin_nameのヘルプを読み込めるようにする
call pathogen#helptags()

"-------------------------------------------------------------------------------
" Common
"-------------------------------------------------------------------------------
set number
syntax on
filetype plugin on
filetype indent on
set textwidth=0
set nowrap

"コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast
" 改行時に自動でコメントをつけるのをやめる
autocmd FileType * setlocal formatoptions-=ro

"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------
" 常にステータスラインを表示
set laststatus=2
set t_Co=256

"-------------------------------------------------------------------------------
" File
"-------------------------------------------------------------------------------
" 更新時自動再読込み
set autoread
" 編集中でも他のファイルを開けるようにする
set hidden
" スワップファイルを作らない
set noswapfile
" バックアップを取らない
set nobackup
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

"-------------------------------------------------------------------------------
"              my config
"-------------------------------------------------------------------------------
" When insert mode, enable hjkl and enable go to home/end.
map <c-e> <END>
map <c-a> <HOME>

nnoremap OA gi<Up>
nnoremap OB gi<Down>
nnoremap OC gi<Right>
nnoremap OD gi<Left>
nnoremap OF gi<End>
nnoremap OH gi<Home>

imap <c-b> <LEFT>
imap <c-n> <DOWN>
imap <c-p> <UP>
imap <c-f> <Right>

imap <c-j> <esc>

imap <c-a> <Home>
imap <c-e> <End>

"inoremap <c-p> <pageup>
"inoremap <c-n> <pagedown>
"inoremap <c-a> <Home>
"inoremap <c-e> <End>

vmap <c-e> <ENd>
vmap <c-a> <HOME>
"-------------------------------------------------------------------------------
" COLOR
"-------------------------------------------------------------------------------
colorscheme molokai
if &term == "xterm-256color"
    colorscheme molokai
    hi Comment ctermfg=102
    hi Visual  ctermbg=236
endif
"--------k-----------------------------------------------------------------------
" カーソル行をハイライト
"-------------------------------------------------------------------------------
" set cursorline
" highlight clear CursorLine
" highlight CursorLine gui=underline
" highlight CursorLine ctermbg=black guibg=black
" highlight Pmenu ctermfg=0 ctermbg=225  guibg=LightMagenta
" highlight PmenuSel ctermfg=0 ctermbg=7  guibg=Gray

"------------------------------------------------------------------------------
" 全角スペースの表示
"-------------------------------------------------------------------------------
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

"-------------------------------------------------------------------------------
" Tab
"-------------------------------------------------------------------------------
set expandtab     "タブ入力を複数の空白入力に置き換える
set tabstop=4     "画面上でタブ文字が占める幅
set shiftwidth=4  "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    "改行時に前の行のインデントを継続する
set smartindent   "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

"-------------------------------------------------------------------------------
" NERDTreeToggle
"-------------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
"-------------------------------------------------------------------------------
" CtrlP
"-------------------------------------------------------------------------------
" map <C-m> :<C-u>CtrlPMRUFiles<Enter>

"-------------------------------------------------------------------------------
" NERDCommenter
"-------------------------------------------------------------------------------
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

"-------------------------------------------------------------------------------
" vimrc help
"-------------------------------------------------------------------------------
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>

"-------------------------------------------------------------------------------
" print datetime
"-------------------------------------------------------------------------------
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

"-------------------------------------------------------------------------------
" encoding
"-------------------------------------------------------------------------------
" encoding(enc)
" vimの内部で使用されるエンコーディングを指定する。
" 編集するファイル内の全ての文字を表せるエンコーディングを指定するべき。
" (日本語を扱うのに latin1 を指定してみたり、Unicodeでしか表せない文字も扱うのにEUC-JPを指定したりしちゃダメ)
:set encoding=utf-8

" fileencoding(fenc)
" そのバッファのファイルのエンコーディングを指定する。バッファにローカルなオプション。
" これに encoding と異なる値が設定されていた場合、ファイルの読み書き時に文字コードの変換が行なわれる。
" fencが空の場合、encodingと同じ値が指定されているものとみなされる。(つまり、変換は行なわれない。)
:set fileencoding=utf-8

" fileencodings(fencs)
" 既存のファイルを編集する際に想定すべき文字コードのリストをカンマ区切りで列挙したものを指定する。
" 編集するファイルを読み込む際には、「指定された文字コード」→「encodingの文字コード」の変換が試行され、
" 最初にエラー無く変換できたものがそのバッファの fenc に設定される。
" fencsに列挙された全ての文字コードでエラーが出た場合、fencは空に設定され、
" その結果、文字コードの変換は行われないことになる。
" fencsにencodingと同じ文字コードを途中に含めると、その文字コードを試行した時点で、
" 「encoding と同じ」→「文字コード変換の必要無し」→「常に変換成功」→「fencに採用」となる。
:set fileencodings=utf-8,cp932
" :set fileencodings=ucs-bom,iso-2022-jp,utf-8,euc-jp,sjis

" 改行コード
:set fileformats=unix,dos,mac

"-------------------------------------------------------------------------------
" 以後、大文字小文字を区別しないで検索するようになる
set ignorecase


