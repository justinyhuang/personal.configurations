" You will need the corresponding .bashrc, .screenrc, .fluxbox and maybe
" .dircolors in order to make Vim work as expected.
" -- Justin.H

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'tpope/vim-fugitive'

Plug 'blueyed/vim-diminactive'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'Shougo/neopairs.vim'

Plug 'easymotion/vim-easymotion'

Plug 'kshenoy/vim-signature'

Plug 'machakann/vim-highlightedyank'

Plug 'rust-lang/rust.vim'

Plug 'majutsushi/tagbar' "to show the current function name in the status line

Plug 'Shougo/neoyank.vim'
Plug 'justinhoward/fzf-neoyank'

" for showing the current context (function/if/for block)
Plug 'wellle/context.vim'

"for fzf-neoyank and neoyank
map ,p ;FZFNeoyank<CR>

Plug 'wellle/visual-split.vim'
"for visual-split
xmap sph <Plug>(Visual-Split-VSSplitAbove)
xmap spl <Plug>(Visual-Split-VSSplitBelow)

Plug 'wellle/targets.vim'

" install the lsps
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" testing lsp-zero
Plug 'VonHeikemen/lsp-zero.nvim'

" try out new complete plugins
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" to dynamically illustrate an indent block
Plug 'echasnovski/mini.indentscope'

" the vscode color scheme
Plug 'Mofiqul/vscode.nvim'

" for using noice
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/noice.nvim'

" to show dynamic indent hint
Plug 'echasnovski/mini.indentscope'

" better substitute
Plug 'gbprod/substitute.nvim'
call plug#end()

"---General Settings---
syntax on                   "turn on syntax highlight
set relativenumber          "show the line number column, relative
set number
set ignorecase
set smartcase
set incsearch
set showcmd
set cindent
set encoding=utf-8

"always show current position
set ruler
set showmode

" set the color scheme
set background=dark

"enable more colors in vim
set t_Co=256
set termguicolors

" for tab exploring
:set showtabline=2
:set tabpagemax=14

"to stop mouse fooling around...
set mouse=

" Fix Backspace problem in Vim
set backspace=2
"set the cursorline and column for the first window
:set cursorline
:set cursorcolumn

"allow :e another file when the current one has unsaved changes
:set hidden

"when search to the end, just tell me, don't start all over
:set nowrapscan


"highlight Constant term=bold cterm=bold ctermfg=6
"
"highlight Comment guibg=Black    guifg=Red    gui=italic
"highlight LineNr  term=NONE
"highlight NonText guifg=Gray95   guibg=Black  gui=bold
"highlight Normal  guibg=Black    guifg=Gray95
"highlight Search  guibg=Cyan     guifg=Black  gui=underline
"highlight Visual  guibg=Yellow   guifg=Black  gui=underline

"visualizing tabs
syntax match Tab /\t/
hi Tab gui=underline guifg=blue ctermbg=blue

"tabs
:set softtabstop=4 shiftwidth=4 expandtab
set smarttab

"indent
:set autoindent wrapmargin=5 textwidth=120
:set smartindent

"dont change the title bar text when we get into vi
set notitle
set icon iconstring=%<%f\ %m
set comments=fn:-sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,n:\\tab,fb:-
set hlsearch

"colors murphy
function FT_cpp()
    set cindent
endfunction

function FT_python()
    set complete+=k~/.vim/syntax/python.vim
    "more python syntax highlighting
    let python_highlight_all = 1
    set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

    set formatoptions=cq foldignore= wildignore+=*.py[co]

    " Highlight end of line whitespace.
    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/

    set list                        " show invisible characters
    set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
endfunction

"rainbow parentheses
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

filetype plugin on
filetype indent on
autocmd FileType cpp            call FT_cpp()
autocmd FileType c              call FT_cpp()
autocmd FileType python         call FT_python()

"Below adds colour if you have a colour xterm, or forward through putty

:if &term =~ "xterm"
:  if has("terminfo")
:    set t_Co=8
:    set t_Sf=[3%p1%dm
:    set t_Sb=[4%p1%dm
:  else
:    set t_Co=8
:    set t_Sf=[3%dm
:    set t_Sb=[4%dm
:  endif
:endif

"to find the cscope tag
function! ImportTag()
python << pyend
import os, vim
_path_list = ['./', '../', '../../', '../../../',
              '../../../../', '../../../../../',
              '../../../../../../', '../../../../../../../']
for path in _path_list:
    if os.path.isfile(path + 'cscope.out') is True:
        vim.command("cs add %(tag_path)s %(code_path)s" %\
                    {'tag_path': path + 'cscope.out',\
                    'code_path': path})
pyend
endfunction

"Below adds support for cscope
if has("cscope")
        silent! call ImportTag()
endif

"for python.vim
let python_highlight_all = 1
let python_slow_sync = 1

"folding settings
"set foldmethod=syntax
set foldmethod=manual
set foldnestmax=10
set nofoldenable
set foldlevel=1
set foldcolumn=2

set laststatus=2

set nospell

"Cool tab completion stuff for command line
set wildmenu
"set wildmode=list:longest,full
set wildmode=full

"i don't need the swap file
set nobackup
set noswapfile
set nowritebackup

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" sets how many lines of history to keep
set history=700

"for regular expressions
set magic
set shortmess=atI               " shorten messages and don't show intro
set showmatch
set matchtime=20

"map space to @ for easier use the record buffer
map <space> @

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Left and right are for switching tabs, not moving the cursor
map [1;5C <C-RIGHT>
map [1;5D <C-LEFT>
map! [1;5C <C-RIGHT>
map! [1;5D <C-LEFT>
map <C-RIGHT> ;tabn<CR>
map <C-LEFT> ;tabp<CR>

"jump to different tabs
" map <DOWN> <C-w><down>
" map <UP> <C-w><up>
" map <LEFT> <C-w><left>
" map <RIGHT> <C-w><right>
map <DOWN> ;tablast<CR>
map <UP> ;tabfirst<CR>
map <LEFT> ;tabprev<CR>
map <RIGHT> ;tabnext<CR>

" Move cursor together with the screen
noremap <c-u> j<c-e>
noremap <c-e> k<c-y>

" up and down are more logical with g
" gk differs from 'k' when lines wrap, and when used with
"an operator, because it's not linewise
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
map ]] ]]zz
map [[ [[zz

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

"open a new tab
map ,e ;tabedit

"shortcut for calling PHX video tools
map ,v ;VIDEOTOOL

nnoremap <silent> <CR> <c-]>
"nnoremap <silent> g<CR> :cs find g <cword> <CR>
nnoremap <silent> c<CR> :cs find c <cword> <CR>
"nnoremap <silent> e<CR> :cs find e <cword> <CR>
"use ripgrep instead
nnoremap <silent> e<CR> :Find expand("<cword>") <CR>

" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
      execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
      execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

function! s:line_handler(l)
  let keys = split(a:l, '  »  ')
  exec keys[0]
  normal! ^zz
endfunction

command! MyFZFLines call fzf#run({
\   'source':  'nl -ba -s "  »  " ' . expand('%:p'),
\   'sink':    function('<sid>line_handler'),
\   'options': '-e --no-sort',
\   'down':    '75%',
\   'window': 'call FloatingFZF("big")'
\})

""# is to show the line number
"map ,f ;g//PP#<Left><Left><Left><Left>
"map ,f ;FilterShowAndJump<CR>
map ,f ;MyFZFLines<CR>

"function MyStreamModify(filter)
"    execute '!sed
"endfunction

" command PP: print lines like :p or :# but with current search pattern highlighted
" This is for the ,f filtering shortcut
"command! -nargs=? -range -bar PP :call PrintWithSearchHighlighted(<line1>,<line2>,<q-args>)
"function! PrintWithSearchHighlighted(line1,line2,arg)
"    let line=a:line1
"    while line <= a:line2
"        echo ""
"        if a:arg =~ "#"
"            echohl LineNr
"            echo strpart(" ",0,7-strlen(line)).line."\t"
"            echohl None
"        endif
"        let l=getline(line)
"        let index=0
"        while 1
"            let b=match(l,@/,index)
"            if b==-1 |
"                echon strpart(l,index)
"                break
"            endif
"            let e=matchend(l,@/,index) |
"            echon strpart(l,index,b-index)
"            echohl Search
"            echon strpart(l,b,e-b)
"            echohl None
"            let index = e
"        endw
"        let line=line+1
"    endw
"endfunction

"format an xml file, do it manually
map fxml ;silent 1,$!xmllint --format --recover - 2>/dev/null

"for indent guide
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" for the plugin Marvim
let marvim_find_key = '<Space>'
let marvin_store_key = ',m'
let marvim_prefix = 0
let marvim_store = expand('~').'/.vim/marvim'

highlight CursorLine guibg=#00242a
highlight CursorColumn guibg=#00242a

hi Pmenu guibg=#002530

" for tabline
hi TabLine      ctermfg=White  ctermbg=Black     cterm=NONE
hi TabLineFill  ctermfg=White  ctermbg=Black     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=19     cterm=NONE

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
    let my_auto_commands_loaded = 1
    " Large files are > 50M
    " Set options:
    " eventignore+=FileType (no syntax highlighting etc
    " assumes FileType always on)
    " noswapfile (save copy of file)
    " bufhidden=unload (save memory when other file is viewed)
    " buftype=nowritefile (is read-only)
    " undolevels=-1 (no undo possible)
    let g:LargeFile = 1024 * 1024 * 50
    augroup LargeFile
        autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
        augroup END
    endif

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'sol'

"define "straight" tabs
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
""define plain separators
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch    = '⭠'
let g:airline_symbols.crypt     = '⭤'
let g:airline_symbols.readonly  = '⭤'
let g:airline_symbols.maxlinenr = '⭡'
let g:airline_symbols.notexists = 'X'
let g:airline_powerline_fonts = 1

let g:airline#extensions#ale#enabled = 1

let g:MultipleSearchMaxColors = 16

"for diminactive plugin
let g:diminactive_enable_focus = 1
hi ColorColumn ctermbg=0 guibg=#002b36

"the code has been commented out because it seems to cause long delay of starting up Vim
"use Vim as a calculator
"example:
":Calc 2**10+5,2**16,2**128
"1029 65536 340282366920938463463374607431768211456
":Calc sin(pi/2), log(10)
"1.0 2.302585
":command! -nargs=+ Calc :py print <args>
":py from math import *
"map ,c ;Calc

"so that 'backspace' in normal mode will go back to the previous buffer
nnoremap <silent> <BS> <C-^>


"fzf related
set rtp+=~/.fzf
set rtp+=~/.vim/plugin
set rtp+=~/.vim/plugin/phx_tools

"-- use the FZF for a much better performance
"map ,a ;FZF<CR>
map ,, ;FZF<CR>

"try using myles with fzf with meta code
" let g:fbfolders = [
"       \ "/data/users/".$USER."/fbsource",
"       \ "/data/users/".$USER."/fbsource/fbcode",
"       \ "/data/users/".$USER."/configerator"
"       \ ]
"
" let g:repo_path = system('hg root')
" let g:repo_prefix = 'f'
" if g:repo_path =~# 'configerator'
"       let g:repo_prefix = 'c'
" elseif repo_path =~# 'fbcode'
"       let g:repo_prefix = 'f'
" endif
"
" if (index(g:fbfolders, getcwd()) >= 0)
"       command! -bang -nargs=? -complete=dir Files call fzf#run({
"           \ 'source': "find . -maxdepth 1 -type f",
"           \ 'sink': 'e',
"           \ 'options': '--bind=change:reload:"myles -n 100 --list {q}"',
"           \'down': '30%'
"           \'window': 'call FloatingFZF("small")'
"           \ })
" endif
" nn <leader>/ :Files <CR>
"
" nnoremap <silent> ,, :call fzf#run({
"           \ 'source': "find . -maxdepth 1 -type f",
"           \ 'sink': 'e',
"           \ 'options': '--bind=change:reload:"myles -n 100 --list {q}"',
"           \'window': 'call FloatingFZF("small")'
"             \ })<CR>

" Jump to tab: ,t
function TabName(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

function! s:jumpToTab(line)
    let pair = split(a:line, ' ')
    let cmd = pair[0].'gt'
    execute 'normal' cmd
endfunction

nnoremap <silent> ,t :call fzf#run({
\   'source':  reverse(map(range(1, tabpagenr('$')), 'v:val." "." ".TabName(v:val)')),
\   'sink':    function('<sid>jumpToTab'),
\   'down':    tabpagenr('$') + 2,
\   'window': 'call FloatingFZF("small")'
\ })<CR>

" enable per-command history
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> ,b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2,
\   'window': 'call FloatingFZF("small")'
\ })<CR>

function! s:bufdelete(e)
    execute 'bd' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> ,d :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufdelete'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2,
\   'window': 'call FloatingFZF("small")'
\ })<CR>

"to use ripgrep in Vim for better Find
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case -u --hidden --follow --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

"for EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"to use a universal buffer across all vim instances
"set clipboard=unnamed

"set the <leader> to be '-'
:let mapleader = "-"

"NEOVIM SPECIFIC SETTINGS ------------------------------------------
set inccommand=nosplit

"for echodoc
set noshowmode
let g:echodoc#enable_at_startup = 1

"for deopairs
let g:neopairs#enable = 1

"for easymotion
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

if executable("rg")
    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)

    nnoremap <C-p>a :Rg
endif

"for vim-highlightedyank
let g:highlightedyank_highlight_duration = 500

"for grepping the current word under the cursor - DISABLE if using BigGrep
nnoremap <silent> ,g :Rg <C-r><C-w><CR>

"to show the current context (normally function name)
nnoremap <C-g> :echo getline(search('\v^[[:alpha:]$_]', "bn", 1, 100))<CR>

"to invoke the video regdef tool on the current word
"nnoremap ,r :VIDEOTOOLregdefsearch <C-r><C-w>

"to be able to see neovim-node-host
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

"to map <Esc> to exit terminal-mode
:tnoremap <Esc> <C-\><C-n>

":Filter to open a new scratch window listing all lines that contain the text that was last searched for
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

"automatically remove trailing spaces on write
autocmd BufWritePre * %s/\s\+$//e

autocmd TermOpen * set nocursorcolumn
autocmd TermOpen * set nocursorline

"for better use of gutentags and gutentags_plus
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root', '.git']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

let g:gutentags_define_advanced_commands = 1


function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')}),
  \ 'window': 'call FloatingFZF("big")'
endfunction

command! Tags call s:tags()

"to display the register list and allow selecting one to be pasted
nnoremap "p :reg <bar> exec 'normal! "'.input('select one to paste >').'p'<CR>

"below is for using floating window in nvim for fzf
au FileType fzf set nonu nornu nomodified nobuflisted noswapfile nocursorline nowrap bufhidden=wipe
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF("big")' }

function! FloatingFZF(size)
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  "set the window to be 9/16 of the 'screen', floating at a middle lower position
  if a:size == "big"
      let height = float2nr(&lines * 3 / 4)
      let width = float2nr(&columns * 3 / 4)
      let col = float2nr((&columns - width) / 2)
      let row = float2nr((&lines - height) * 25 / 32)
  else
      let height = float2nr(&lines * 1 / 4)
      let width = float2nr(&columns * 3 / 4)
      let col = float2nr((&columns - width) / 2)
      let row = float2nr((&lines - height) * 18 / 32)
  endif

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction
highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#002931

"open a floating terminal window
nnoremap ,s :call FloatingTerminal() <CR>
function! FloatingTerminal() abort
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  "open a terminal window that is 1/4 the size of the 'screen', and float at a middle lower position
  let height = float2nr(&lines * 1 / 2)
  let width = float2nr(&columns * 1 / 2)
  let col = float2nr((&columns - width) / 2)
  let row = float2nr((&lines - height) * 25 / 32)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
  setlocal nobuflisted
  setlocal noswapfile
  setlocal nonumber
  setlocal norelativenumber
  setlocal nocursorline
  setlocal nowrap
  terminal
  startinsert

endfunction

"below is an example of using floating window to show some info
nnoremap ,r :call ShowPopup(expand("<cword>")) <CR>

function! ShowPopup(content) abort
    let width = 100
    let height = 100
    let s:popup_win_id = nvim_open_win(
        \   bufnr('%'),
        \   v:true,
        \   {
        \       'relative': 'cursor',
        \       'anchor': corner,
        \       'row': row,
        \       'col': col,
        \       'width': width,
        \       'height': height,
        \   }
        \ )
    enew!

    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nomodified
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nonumber
    setlocal norelativenumber
    setlocal nocursorline
    setlocal nowrap
    nmap <silent> <buffer> q :close<CR>

    call setline(1, "you select the word below")
    call append(line('$'), a:content)
    setlocal nomodified
    setlocal nomodifiable

    " go to the original window
    wincmd p

    augroup VtmClosePopup
        autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> call <SID>ClosePopup()
    augroup END
endfunction

function! s:ClosePopup() abort
    let popup_winnr = win_id2win(s:popup_win_id)
    if popup_winnr != 0
        execute popup_winnr . 'wincmd c'
    endif
    autocmd! VtmClosePopup * <buffer>
endfunction

function! s:GetFloatingPosition(width, height) abort
    let bottom_line = line('w0') + winheight(0) - 1
    let curr_pos = getpos('.')
    if curr_pos[1] + a:height <= bottom_line
        let vert = 'N'
        let row = 1
    else
        let vert = 'S'
        let row = 0
    endif

    if curr_pos[2] + a:width <= &columns
        let hor = 'W'
        let col = 0
    else
        let hor = 'E'
        let col = 1
    endif

    return [row, col, vert . hor]
endfunction

" nvim-cmp related
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

" using fbgs
command! -bang -nargs=* Bg
      \ call fzf#vim#grep(
      \   'fbgs.wrapper.py '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <C-p>a :Bg

"for grepping the current word under the cursor, using Meta's big grep
"nnoremap <silent> ,g :Bg <C-r><C-w><CR>

" use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

colorscheme vscode

" setup noice
lua <<EOF
require("noice").setup({
  routes = {
    {
      filter = { error = true},
      view = "mini",
    },
  }
})
EOF

:set cmdheight=1

" configure the indentscope animation, shape and color
lua <<EOF
require('mini.indentscope').setup{
  draw = {
    delay = 70,
    priority = 2,
    animation = function(s, n)
      return s/n*20
    end,
  },
  symbol = '│',
}
EOF
hi MiniIndentscopeSymbol guifg=#444444

" to configure the substitute plugin
lua <<EOF
vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
EOF

" to enable the treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup{
   highlight = {
      enable = true,
   },
}
EOF

lua <<EOF
local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
EOF

" to start mason for lsp and related services
lua <<EOF
   require("mason").setup()
   require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer", "clangd", "pylyzer" },

   })
   -- a macro to setup all the LSP that are installed
   require("mason-lspconfig").setup_handlers({
      function(server_name)
         require("lspconfig")[server_name].setup({})
      end,
   })
EOF

lua <<EOF
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})
EOF
