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
    set guifont=YaHei\ Consolas\ Hybrid:h12
    set guioptions=
    "colorscheme molokai
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

if has('statusline')
    " Always show the status line
    set laststatus=2
    set statusline=
    set statusline+=%-3.3n\                          " buffernumber
    set statusline+=%f\                              " filename
    set statusline+=%h%m%r%w                         " statusflags
    set statusline+=\[%{strlen(&ft)?&ft:'none'}]     " filetype
    set statusline+=\[%{strlen(&fenc)?&fenc:'none'}] " fileencoding
    set statusline+=\[%{strlen(&ff)?&ff:'none'}]     " fileformat
    set statusline+=%=                               " rightalignremainder
    set statusline+=0x%-5B                           " charactervalue
    set statusline+=%-14(%l,%c%V%)                   " line,character
    set statusline+=%-8o                             " byte
    set statusline+=%<%P                             " fileposition
endif
highlight StatusLine ctermbg=Green ctermfg=DarkBlue guibg=Orange guifg=SeaGreen
highlight StatusLineNC ctermbg=Gray ctermfg=DarkBlue guibg=Gray guifg=SeaGreen

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType vim,c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

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
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/ap <leader>tm :tabmove

" To insert timestamp, press F3.
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Some helpers to edit mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Misc {
let g:NERDShutUp=1
let b:match_ignorecase = 1
" }

" Ctags {
set tags=./tags,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif
" }

" OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
endif

highlight Pmenu      guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
highlight PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
highlight PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" Some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }

" NerdTree {
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
" }

" NerdCommenter {
let NERDSpaceDelims=1
" }

" UndoTree {
nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1
" }

" ctrlp {
let g:ctrlp_working_path_mode = 'ra'
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>q :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

"" On Windows use "dir" as fallback command.
"if WINDOWS()
"let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
"elseif executable('ag')
"let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
"elseif executable('ack-grep')
"let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
"elseif executable('ack')
    "let s:ctrlp_fallback = 'ack %s --nocolor -f'
"else
    "let s:ctrlp_fallback = 'find %s -type f'
"endif
"let g:ctrlp_user_command = {
            "\ 'types': {
            "\ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            "\ 2: ['.hg', 'hg --cwd %s locate -I .'],
            "\ },
            "\ 'fallback': s:ctrlp_fallback
            "\ }

" CtrlP extensions
let g:ctrlp_extensions = ['funky']

"funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
"}

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru $VIM/vimfiles/ftplugin/html/autoclosetag.vim
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" neocomplcache {
let g:acp_enableAtStartup                        = 0
let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case            = 1
let g:neocomplcache_enable_underbar_completion   = 1
let g:neocomplcache_enable_auto_delimiter        = 1
let g:neocomplcache_max_list                     = 15
let g:neocomplcache_force_overwrite_completefunc = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns._ = '\h\w*'

" Plugin key-mappings {
inoremap <CR> <CR>
" <ESC> takes you out of insert mode
inoremap <expr> <Esc>   pumvisible()           ? "\<C-y>\<Esc>" : "\<Esc>"
" <CR> accepts first, then sends the <CR>
inoremap <expr> <CR>    pumvisible()           ? "\<C-y>\<CR>" : "\<CR>"
" <Down> and <Up> cycle like <Tab> and <S-Tab>
inoremap <expr> <Down>  pumvisible()           ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>    pumvisible()           ? "\<C-p>" : "\<Up>"
" Jump up and down the list
inoremap <expr> <C-d>   pumvisible()           ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>   pumvisible()           ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
" <TAB>: completion.
inoremap <expr><TAB>    pumvisible()           ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible()           ? "\<C-p>" : "\<TAB>"
" }

" Enable omni completion.
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby          setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell       setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.go   = '\h\w*\.\?'
" }

" indent_guides {
let g:indent_guides_start_level           = 2
let g:indent_guides_guide_size            = 1
let g:indent_guides_enable_on_vim_startup = 1
" }

" SnipMate {
" Setting the author var
let g:snips_author = 'liuhaiyun <liuhaiyun@zlg.cn>'
" }

" TagBar {
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" If using go please install the gotags program using the following
" go install github.com/jstemmer/gotags
" And make sure gotags is in your path
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
            \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
            \ 'r:constructor', 'f:functions' ],
            \ 'sro' : '.',
            \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
            \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
"}

" Tabularize {
nmap <Leader>a&     :Tabularize /&<CR>
vmap <Leader>a&     :Tabularize /&<CR>
nmap <Leader>a=     :Tabularize /=<CR>
vmap <Leader>a=     :Tabularize /=<CR>
nmap <Leader>a=>    :Tabularize /=><CR>
vmap <Leader>a=>    :Tabularize /=><CR>
nmap <Leader>a:     :Tabularize /:<CR>
vmap <Leader>a:     :Tabularize /:<CR>
nmap <Leader>a::    :Tabularize /:\zs<CR>
vmap <Leader>a::    :Tabularize /:\zs<CR>
nmap <Leader>a,     :Tabularize /,<CR>
vmap <Leader>a,     :Tabularize /,<CR>
nmap <Leader>a,,    :Tabularize /,\zs<CR>
vmap <Leader>a,,    :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" Session List {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>
" }

" Wildfire {
let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
            \ "html,xml" : ["at"],
            \ }
" }

" Over {
nmap <leader>oc :OverCommandLine<CR>
vmap <leader>oc :OverCommandLine<CR>
" }

" Rainbow {
let g:rainbow_active = 1
" }

" showmarks {
let g:showmarks_enable = 0
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

