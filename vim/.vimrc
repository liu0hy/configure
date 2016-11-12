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
set backup
if has('persistent_undo')
    " So is persistent undo ...
    set undofile
    " Maximum number of changes that can be undone
    set undolevels=1000
    " Maximum number lines to save for undo on a buffer reload
    set undoreload=10000
endif
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

" Remove trailing whitespaces and ^M chars
autocmd FileType vim,c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

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

" Map g* keys in Normal, Operator-pending, and Visual+select
noremap $ :call WrapRelativeMotion("$")<CR>
noremap <End> :call WrapRelativeMotion("$")<CR>
noremap 0 :call WrapRelativeMotion("0")<CR>
noremap <Home> :call WrapRelativeMotion("0")<CR>
noremap ^ :call WrapRelativeMotion("^")<CR>
" Overwrite the operator pending $/<End> mappings from above
" to force inclusive motion with :execute normal!
onoremap $ v:call WrapRelativeMotion("$")<CR>
onoremap <End> v:call WrapRelativeMotion("$")<CR>
" Overwrite the Visual+select mode mappings from above
" to ensure the correct vis_sel flag is passed to function
vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'mkitt/tabline.vim'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'vim-scripts/a.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'Townk/vim-autoclose'
Plugin 'osyo-manga/vim-over'
Plugin 'luochen1990/rainbow'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'plasticboy/vim-markdown'
Plugin 'mhinz/vim-startify'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Airline {
let g:airline_powerline_fonts = 1
" }

" Tagbar {
nmap <F8> :TagbarToggle<CR>
" }

" Undotree {
nnoremap <F9> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
" }

" NERDTree {
nmap <F7> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen = 1
" }

" Tabular {
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
" }

" EasyMotion {
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" }

" incsearch {
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#auto_nohlsearch = 1
" }

" syntastic {
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
" }

" indent_guides {
let g:indent_guides_start_level           = 2
let g:indent_guides_guide_size            = 1
let g:indent_guides_enable_on_vim_startup = 1
" }

" vim-session {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
let g:session_autosave = 'no'
nmap <leader>so :OpenSession<CR>
nmap <leader>ss :SaveSession<Space>
nmap <leader>sc :CloseSession<CR>
nmap <leader>sd :DeleteSession<CR>
" }

" rainbow {
let g:rainbow_active = 1
" }

" ultisnips {
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction

call InitializeDirectories()

function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
        let vis_sel="gv"
    endif
    if &wrap
        execute "normal!" vis_sel . "g" . a:key
    else
        execute "normal!" vis_sel . a:key
    endif
endfunction

