" Personal Deep Customized Vim RC file
" You will need the corresponding .bashrc, .screenrc, .fluxbox and maybe
" .dircolors in order to make Vim work as expected.
" -- Justin.H

"---General Settings---
syntax on                   "turn on syntax highlight
set relativenumber          "show the line number column, relative
"set number
set ignorecase
set smartcase
set incsearch
set showcmd
set cindent

"always show current position
set ruler
set showmode

"for fzf
set rtp+=~/.fzf

" Insert the charcode segment after the filetype segment
"call Pl#Theme#InsertSegment('filesize', 'after', 'lineinfo')

" change the <Leader> mapping
:let mapleader = "\\"
" set the color scheme
let g:solarized_termcolors=256
set background=light
colorscheme solarized

"enable more colors in vim
set t_Co=256
" for tab exploring
:set showtabline=2
:set tabpagemax=14

"to have mouse fooling around...
":set mouse=a

"to not use the X clipboard, helping to start Vim a lot faster
set clipboard=exclude:.*

" Fix Backspace problem in Vim
set backspace=2
":set t_kb=
":fixdel
"set the cursorline and column for the first window
:set cursorline
:set cursorcolumn
"set the cursorline and column for any window that we swich to
":au WinEnter * :set cursorline
":au WinEnter * :set cursorcolumn
"remove the cursorline and column when in insert mode
":autocmd InsertEnter,InsertLeave * set cursorline!
":autocmd InsertEnter,InsertLeave * set cursorcolumn!

"when search to the end, just tell me, don't start all over
:set nowrapscan

" setting for Tlist
let Tlist_Use_Right_Window=1
let Tlist_file_Fold_Auto_Close=1
let Tlist_Auto_Update=1
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
" setting for TagExplorer
"let TE_Ctags_path='/usr/bin/ctags'
let TE_Ctags_path='/usr/bin/cscope'

" setting for ShowMarks
map <F2> <leader>mt

highlight Constant term=bold cterm=bold ctermfg=6

highlight Comment guibg=Black    guifg=Red    gui=italic
highlight LineNr  term=NONE
highlight NonText guifg=Gray95   guibg=Black  gui=bold
highlight Normal  guibg=Black    guifg=Gray95
highlight Search  guibg=Cyan     guifg=Black  gui=underline
highlight Visual  guibg=Yellow   guifg=Black  gui=underline

"visualizing tabs
syntax match Tab /\t/
hi Tab gui=underline guifg=blue ctermbg=blue

"tabs
:set softtabstop=4 shiftwidth=4 expandtab
set smarttab

"indent
:set autoindent wrapmargin=5 textwidth=120
:set smartindent

:set title titlestring=%<%f\ %m%=ft=%y\ \ \ \ \ \ \ \ Line\ %l\ /\ %L\ \ \ (%P)\ \ \ \ \ \ \ \ %a titlelen=100

"dont change the title bar text when we get into vi
set notitle
set icon iconstring=%<%f\ %m
set comments=fn:-sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,n:\\tab,fb:-
set hlsearch

"colors murphy
nnoremap <silent> <F4> :Tlist<CR>
nnoremap <silent> <F3> :TagExplorer<CR>
function FT_cpp()
    set cindent
    map <F7> 0i//--<Esc>+
    map <F8> -/^\/\/--<CR>4x
    source $HOME/.vim/cppMacros.vim
    " for rainbow parentheses highlight
    :RainbowParenthesesToggle       " Toggle it on/off
    :RainbowParenthesesLoadRound    " (), the default when toggling
    :RainbowParenthesesLoadSquare   " []
    :RainbowParenthesesLoadBraces   " {}
    ":RainbowParenthesesLoadChevrons " <>)

endfunction

function FT_java()
    set cindent
    map <F7> 0i//-- <Esc>+
    map <F8> -/^\/\/-- <CR>5x
    source $HOME/.vim/javaMacros.vim
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
    " for rainbow parentheses highlight
    :RainbowParenthesesToggle       " Toggle it on/off
    :RainbowParenthesesLoadRound    " (), the default when toggling
    :RainbowParenthesesLoadSquare   " []
    :RainbowParenthesesLoadBraces   " {}
    ":RainbowParenthesesLoadChevrons " <>)
endfunction

filetype plugin on
filetype indent on
autocmd FileType cpp            call FT_cpp()
autocmd FileType c              call FT_cpp()
autocmd FileType java           call FT_java()
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

"looks for the tag file all the way up, until one is found
set tags=tags;/

"for pydiction
filetype plugin on

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

set nobackup

set laststatus=2

set nospell

"Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

"remove the buffer when closing a tab
set nohidden

"i don't need the swap file
set noswapfile
set nowritebackup

set encoding=utf8

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" soft wrap long lines
" set wrap

" sets how many lines of history to keep
set history=700

"for regular expressions
set magic
set shortmess=atI               " shorten messages and don't show intro
set showmatch
set matchtime=20

"high light current word
"au CursorMoved <buffer> exe 'match flicker /\k*\%#\k*/'

"set the cursor shape in gui
set guicursor=a:ver30-iCursor-blinkwait300-blinkon200-blinkoff150

"map space to @ for easier use the record buffer
map <space> @

"map for easier CHECKPOINT adding at work in HP
map cp A -DRT_B -DRT_C<Esc>

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
map <DOWN> ;tablast<CR>
map <UP> ;tabfirst<CR>
map <LEFT> ;tabp<CR>
map <RIGHT> ;tabn<CR>

" Move cursor together with the screen
noremap <c-j> j<c-e>
noremap <c-k> k<c-y>

"to open a conque terminal window in Vim
map ,s ;ConqueTermSplit bash<CR>

" for Error Window
map <F9> ;cw<CR>
map <F10> ;ccl<CR>
map <F11> ;cprev<CR>
map <F12> ;cnext<CR>

"diff files inside vim
"map vd ;vert diffsplit  "disabled as i use vdo.thor more often than vert diffsplit

" for moving in Insert mode
imap <C-j> <DOWN>
imap <C-k> <UP>
imap <C-h> <LEFT>
imap <C-l> <RIGHT>

" not to even think about the <ESC> key
imap jj <ESC>

"delete a word in insert mode
imap jjd <ESC>diwxa

"capitalize the first character of the current word, in Insert mode
imap jjc <ESC>b~A

"what is this?
imap <C-p> <C-x><C-o>


"map for short cut of omni completion feature
"imap <C-u> <C-x><C-o>

" up and down are more logical with g
" gk differs from 'k' when lines wrap, and when used with
"an operator, because it's not linewise
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

map ]] ]]zz
map [[ [[zz

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

"map a shortcut for switching between windows.
"next window
map ,nw <C-w>w
map ,pw <C-w>W
"what is this?
map ,nn <C-^><C-^>
"page down
map ,j <C-d>
"page up
map ,k <C-u>
"next tab
map ,nt ;tabn<CR>
"previous tab
map ,pt ;tabp<CR>
"open a new tab
map ,e ;tabedit
"highlight search
map ,/ ;Search 
map ,// ;SearchReset

"shortcut for calling PHX video tools
map ,v ;VIDEOTOOL

"for ctags and cscope
"use ctags for searching the definition as sometimes cscope
"just can't find the definition
map ,g ;tag
map ,c ;cs find c

"return on a word and go to the definition
nnoremap <silent> <CR> :tag <cword> <CR>
nnoremap <silent> c<CR> :cs find c <cword> <CR>
nnoremap <silent> g<CR> :cs find g <cword> <CR>
nnoremap <silent> e<CR> :cs find e <cword> <CR>

" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
      execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
      execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0

"use ctrlp instead of fuzzy finder
"open a file from the filelist
"map ,, ;CtrlP<CR>
"-- use the FZF for a much better performance
map ,, ;FZF<CR>
"do not clear the cache on exit
let g:ctrlp_clear_cache_on_exit = 0
"set regexp search as the default
let g:ctrlp_regexp = 1
"The maximum number of files to scan, set to 0 for no limit
let g:ctrlp_max_files = 0
"skip the gen directories
let g:ctrlp_custom_ignore = 'gen$'
"only update the results after stopping typing for 250ms
let g:ctrlp_lazy_update = 1

"filter the content with keyword
"map ,f ;g//p<Left><Left>
map ,f ;g//PP<Left><Left><Left>
map ,p ;YRShow

" command PP: print lines like :p or :# but with current search pattern highlighted
" This is for the ,f filtering shortcut
command! -nargs=? -range -bar PP :call PrintWithSearchHighlighted(<line1>,<line2>,<q-args>)
function! PrintWithSearchHighlighted(line1,line2,arg)
    let line=a:line1
    while line <= a:line2
        echo ""
        "i am not sure how to pass the arg to the function,
        "and i need to see the line numbers, so i just remove
        "the checking to display line numbers all the time
        "if a:arg =~ "#"
            echohl LineNr
            echo strpart(" ",0,7-strlen(line)).line."\t"
            echohl None
        "endif
        let l=getline(line)
        let index=0
        while 1
            let b=match(l,@/,index)
            if b==-1 |
                echon strpart(l,index)
                break
            endif
            let e=matchend(l,@/,index) |
            echon strpart(l,index,b-index)
            echohl Search
            echon strpart(l,b,e-b)
            echohl None
            let index = e
        endw
        let line=line+1
    endw
endfunction

"format an xml file, do it manually
map fxml ;silent 1,$!xmllint --format --recover - 2>/dev/null

"for indent guide
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"map the awkward key combination of omni complete to ctrl+space
inoremap <Nul> <C-x><C-n>

" for the plugin Marvim
let marvim_find_key = '<Space>'
let marvin_store_key = ',m'
let marvim_prefix = 0
let marvim_store = expand('~').'/.vim/marvim'

" for neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#max_keyword_width = 120
let g:neocomplete#sources#buffer#max_keyword_width = 255

" for UltiSnips
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"set diffexpr=BCDiff()
"function BCDiff()
"    silent execute "!bcompare @bcompare.script " . v:fname_in . " " . v:fname_new . " " . v:fname_out
"endfunction

"for highlighting the current window
"augroup BgHighlight
"    autocmd!
"    autocmd WinEnter * set cursorline
"    autocmd WinEnter * set cursorcolumn
"    autocmd WinLeave * set nocursorline
"    autocmd WinLeave * set nocursorcolumn
"augroup END

highlight CursorLine ctermbg=7
highlight CursorColumn ctermbg=7

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

" Adapted from unimpaired.vim by Tim Pope.
function! s:DoAction(algorithm,type)
  " backup settings that we will change
  let sel_save = &selection
  let cb_save = &clipboard
  " make selection and clipboard work the way we need
  set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
  " backup the unnamed register, which we will be yanking into
  let reg_save = @@
  " yank the relevant text, and also set the visual selection (which will be reused if the text
  " needs to be replaced)
  if a:type =~ '^\d\+$'
    " if type is a number, then select that many lines
    silent exe 'normal! V'.a:type.'$y'
  elseif a:type =~ '^.$'
    " if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    " line-based text motion
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    " block-based text motion
    silent exe "normal! `[\<C-V>`]y"
  else
    " char-based text motion
    silent exe "normal! `[v`]y"
  endif
  " call the user-defined function, passing it the contents of the unnamed register
  let repl = s:{a:algorithm}(@@)
  " if the function returned a value, then replace the text
  if type(repl) == 1
    " put the replacement text into the unnamed register, and also set it to be a
    " characterwise, linewise, or blockwise selection, based upon the selection type of the
    " yank we did above
    call setreg('@', repl, getregtype('@'))
    " relect the visual region and paste
    normal! gvp
  endif
  " restore saved settings and register value
  let @@ = reg_save
  let &selection = sel_save
  let &clipboard = cb_save
endfunction

function! s:ActionOpfunc(type)
  return s:DoAction(s:encode_algorithm, a:type)
endfunction

function! s:ActionSetup(algorithm)
  let s:encode_algorithm = a:algorithm
  let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'ActionOpfunc'
endfunction

function! MapAction(algorithm, key)
  exe 'nnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>ActionSetup("'.a:algorithm.'")<CR>g@'
  exe 'xnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",visualmode())<CR>'
  exe 'nnoremap <silent> <Plug>actionsLine'.a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",v:count1)<CR>'
  exe 'nmap '.a:key.'  <Plug>actions'.a:algorithm
  exe 'xmap '.a:key.'  <Plug>actions'.a:algorithm
  exe 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:algorithm
endfunction

"reverse the selected text object
function! s:ReverseString(str)
    let out = join(reverse(split(a:str, '\zs')), '')
    " Remove a trailing newline that reverse() moved to the front.
    let out = substitute(out, '^\n', '', '')
    return out
endfunction
call MapAction('ReverseString', '<leader>r')"

"open the selected link
function! s:OpenUrl(str)
    silent execute "!firefox ".shellescape(a:str, 1)
    redraw!
endfunction

"Only show line numbers in current split
":au WinEnter * :setlocal number
":au WinLeave * :setlocal nonumber

"configure YankRing so that the setup of clipboard won't take much time during boot up
let g:yankring_max_history = 7
let g:yankring_max_element_length = 65536
:let  g:yankring_default_menu_mode = 1

execute pathogen#infect()
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'sol'

"define "straight" tabs
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
""define plain separators
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'

let g:MultipleSearchMaxColors = 16

let g:diminactive_enable_focus = 1

"use Vim as a calculator
"example:
":Calc 2**10+5,2**16,2**128
"1029 65536 340282366920938463463374607431768211456
":Calc sin(pi/2), log(10)
"1.0 2.302585
:command! -nargs=+ Calc :py print <args>
:py from math import *

"so that 'backspace' in normal mode will go back to the previous buffer
nnoremap <silent> <BS> <C-^>


"fzf related
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
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
