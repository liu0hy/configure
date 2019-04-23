"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Identify platform {
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction
" }

" Basics {
" Use Vim Settings (No Vi). This must be first, because it
" changes other options as a side effect.
set nocompatible
if !WINDOWS()
    set shell=/bin/sh
endif
" }

" Set the character encoding used inside Vim
set encoding=utf-8
set fileencodings=ucs-bom,utf8,cp936,big5,euc-jp,euc-kr,gb18130,latin1
set termencoding=utf-8
" Language to use for menu translation
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Set the language used for messages
language messages zh_CN.utf-8
" Set Dos as the standard file type
if (WINDOWS())
    set fileformats=dos,unix
elseif (OSX())
    set fileformats=mac,unix,dos
else
    set fileformats=unix,dos
endif
if has('gui_running')
    " Font will be used for the GUI version of Vim
    if (WINDOWS())
        set guifont=YaHei\ Consolas\ Hybrid:h12
    endif
    set guioptions=
else
    colorscheme default
endif
highlight VertSplit ctermbg=Gray ctermfg=DarkBlue guibg=Gray guifg=SeaGreen

" Automatically detect file types.
filetype plugin indent on
" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Abbrev. of messages
set shortmess+=a
" Always switch to the current file directory
set autochdir
" Allow for cursor beyond last character
set virtualedit=onemore
" Allow buffer switching without saving
set hidden
" Case insensitive search
set ignorecase
" Caes sensitive when uc present
set smartcase
" Indent at the same level of the previous line
set autoindent
" Do smart autoindenting
set smartindent
" Line numbers on
set number
" Relative line numbers on
set relativenumber
" Show matching brackets/parenthesis
set showmatch
" How many tenths of a second to blink when matching brackets/parenthesis
set matchtime=2
" Search as you type.
set incsearch
" Highlight search terms
set hlsearch
" SignColumn should match background
highlight clear SignColumn
" Current line number row will have same background color in relative mode
highlight clear LineNr
" Backups are nice ...
set nobackup
set noundofile
" Use indents of 4 spaces
set shiftwidth=4
" Tabs are spaces, not tabs
set expandtab
" An indentation every four columns
set tabstop=4
" Let backspace delete indent
set softtabstop=4
set smarttab
" Highlight current line
set cursorline
" Screen columns that are highlighted with ColorColumn
set colorcolumn=80
if has('cmdline_info')
    " Show line number, cursor position.
    set ruler
    " Display incomplete commands.
    set showcmd
endif
" Lines longer than the width of the window will wrap and
" displaying continues on the next line
set wrap
" Show autocomplete menus.
set wildmenu
" Command <Tab> completion, list matches, then longest common part, then all
set wildmode=list:longest,full
" Ignore files
set wildignore+=*~,*.o,*.obj
" Backspace for dummies
set backspace=indent,eol,start
" Backspace and cursor keys wrap too
set whichwrap=b,s,h,l,<,>,[,]
" Lines to scroll when cursor leaves screen
set scrolljump=5
" Minimum lines to keep above and below cursor
set scrolloff=3
" Display the current mode
set showmode
" Auto fold code
set foldenable
" Lines with equal indent form a fold
set foldmethod=syntax
set foldlevelstart=99
" Display unprintable characters with '^' and put $ after the line
set list
" Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces
" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow
" Height of the command bar
set cmdheight=2
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Always report number of lines changed
set report=0
" Wait for ambiguous mapping
set timeoutlen=300
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  " Display the line with tab page labels only if there are at least two
  " tab pages
  set showtabline=1
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

set laststatus=2

set t_Co=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => KeyMaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let maplocalleader = '_'

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Fast saving
nmap <leader>w :w!<cr>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Fast opening and closing a fold
nnoremap <space> za

" Clear the current search results
" nmap <silent> <leader>/ :nohlsearch<CR>
" Toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
vnoremap . :normal .<CR>

" Useful mappings for managing tabs
map <leader>tt :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tp :tabprevious<CR>
map <leader>tn :tabnext<CR>

" Some helpers to edit mode
map <leader>ew :e<Space>
map <leader>es :sp<Space>
map <leader>ev :vsp<Space>
map <leader>et :tabe<Space>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Pressing ,ss will toggle and tn toggle spell checking
map <leader>st :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sd zw
map <leader>s? z=

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

map <C-K> :pyf ~/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-14.04/share/clang/clang-format.py<cr>


