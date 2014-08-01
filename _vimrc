call pathogen#infect()
runtime! plugin/sensible.vim

" Basics 
set nocompatible
set hidden " allow unsaved background buffers and remember marks/undo for them
set history=10000 " remember more commands and search history
set shell=sh " make plugins not break when I'm using a non-posix shell

set noexrc
set background=dark
syntax on
syntax sync fromstart

"
" General
filetype plugin indent on
set noautochdir " Change the working directory when opening a file

set backspace=indent,eol,start
set backup
set directory=~/.vimtmp/swap
set backupdir=~/.vimtmp/backup

set clipboard+=unnamed " share windows clipboard
set iskeyword+=_,$,@,%,#
set mouse=a
set noerrorbells
set whichwrap=b,s,<,>,~,[,]
set fileformats=unix,dos " Set unix line endings as the default

"Vim UI
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cursorline
set winwidth=90 " minimum buffer width, including line numbers
set switchbuf=useopen


set lazyredraw
set linespace=0
set list
set listchars=tab:>-,trail:-
set noshowmatch "Show matching brackets for a moment
set nostartofline
set novisualbell
set numberwidth=5
set report=0
set ruler
set scrolloff=10
set shortmess=aOstT
set showcmd
"set relativenumber " Show relative line numbers
set nu! " Show line numbers

" Text formatting and layout
set expandtab
set tabstop=8
set noignorecase
set infercase
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set smartcase
set shiftwidth=4
set softtabstop=4
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set autoindent
set nowrap

let mapleader=","
" Folding
set foldmethod=indent
set nofoldenable
set foldlevel=1


set smarttab

" Smart indenting
set smartindent
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
    " Clear all autocmds in the group
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,coffee,sass,cucumber set ai sw=2 sts=2 et
    autocmd FileType python set ts=8 sw=4 sts=4 et
    autocmd FileType aspx set sw=4 ts=4 net
    autocmd FileType xml set sw=4 ts=4 sts=4 et
    autocmd FileType make set noexpandtab sw=0 sts=0
augroup END
au BufRead,BufNewFile *.md set filetype=markdown

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

set autoread
au CursorHold * checktime " Prompt to reload when cursor has been still for 4 seconds
" WinEnter or BufWinEnter are also events that can be checked on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <c-c> <esc>
map Y y$
map <leader>v :vsplit<cr>
map <leader>s :split<cr>
map <leader>e :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INDENT PYTHON LIKE GOOGLE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function GetGooglePythonIndent(lnum)
  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif
  return GetPythonIndent(a:lnum) " Delegate the rest to the original function.
endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("win32")
"
"set runtimepath^=~/vimfiles/bundle/ctrlp.vim
"nnoremap <silent> <Leader>t :CtrlP<CR>
"nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
"let g:ctrlp_working_path_mode = 2
"set wildignore+=tmp/*,log/*,*.so,*.swp,*.zip,*.exe,*.pyc    " Windows
"let g:ctrlp_match_window_reversed = 1 " Match Command-t behavior
"
"if has("macunix")
"    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif
"
"endif
"

" Unite
"nnoremap <silent> <Leader>t :Unite file_rec/async<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-T and Powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("unix")
    " Powerline
    " let g:Powerline_symbols = 'fancy'
    " New version of powerline throws all sorts of syntax errors. :(
    " set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

    " Command-T
    let g:CommandTMaxHeight=15
    map <leader>f :CommandTFlush<CR>
    if &term =~ 'xterm' || &term =~ 'screen' " swapped out quotes to comment out
        let g:CommandTCancelMap     = ['<Esc>', '<C-c>']
        let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>0B']
        let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>0A']
    endif

    set wildignore+=node_modules/**,public/js/**
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_enable_signs=1
let g:pyflakes_use_quickfix = 1 "set to 0 to disable
let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! AirlineInit()
"    let g:airline_section_a = airline#section#create(['mode']) "branch
"    let g:airline_section_y = airline#section#create(['%P'])
"    let g:airline_section_z = airline#section#create(['%l', ':', '%c'])
"endfunction
"autocmd VimEnter * call AirlineInit()
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#show_message = 0
"let g:airline#extensions#branch#enabled = 0

if has("gui_running")

    set guioptions=ce
    let g:molokai_original=1
    colorscheme molokai
    if has("macunix")
        set guifont=Menlo\ Regular\ for\ Powerline:h11
        "let g:airline_powerline_fonts = 1
        "let g:airline_theme = 'powerlineish'
    else
        set guifont=Ubuntu\ Mono\ for\ Powerline\ 11,Consolas:h10:cANSI
    endif
    set go-=T
    set columns=190
    set lines=78
else
    set background=dark
    set t_Co=256
    colorscheme molokai
    "let g:airline_left_sep=''
    "let g:airline_right_sep=''
endif
