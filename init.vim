call plug#begin('~/.local/share/nvim/plugged')

" Fugitive
Plug 'tpope/vim-fugitive'

" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'roxma/nvim-completion-manager'
Plug 'phpactor/phpactor', {'do': 'composer install'}
Plug 'roxma/ncm-phpactor'

" Python
Plug 'roxma/python-support.nvim'

" Supertab
Plug 'ervandew/supertab'

" Auto closing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

" NERD tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Syntax
Plug 'scrooloose/syntastic'
Plug 'bronson/vim-trailing-whitespace'

" Unite
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'

" Aligning
Plug 'junegunn/vim-easy-align'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" PHP
Plug 'StanAngeloff/php.vim'

" Refactoring tools
Plug 'adoy/vim-php-refactoring-toolbox'

" Colors
Plug 'altercation/vim-colors-solarized'

" Indent guides
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" Leader key map
    let mapleader = "ł"

" Vim Gutentags
    let g:gutentags_project_root = [ '~/Documents/adomee' ]

" Toggle tagbar
    nmap <F8> :TagbarToggle<CR>

" highlight 80th col
    if (exists('+colorcolumn'))
    	set colorcolumn=80
    	highlight ColorColumn ctermbg=7
    endif

" Unite conf
    let g:unite_source_history_yank_enable = 1
    try
    	let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    	call unite#filters#matcher_default#use(['matcher_fuzzy'])
    catch
    endtry

" Toggling NERD tree
    map <C-n> :NERDTreeToggle<CR>

" Close nvim if the only pane is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" search a file in the filetree
    nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
    nnoremap <space>r <Plug>(unite_restart)

" EasyAlign
    vnoremap <silent> <<CR>> :EasyAlign<cr>

" PHP Stuff
    let g:syntastic_php_checkers = ['php', 'phpcs']

" Phpactor stuff
    let g:phpactorPhpBin = "php"
    let g:phpactorOmniError = v:true
    autocmd FileType php setlocal omnifunc=phpactor#Complete

" Context menu
    nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Class/member definition navigation
    nmap <Leader>o yiw:tag <C-R>"<CR>

" Close autocomplete menu when Enter is pressed
    inoremap <expr> <C-CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Airline
    let g:airline_theme='solarized'
    let g:airline_powerline_fonts=1

""" Personal
" Some main editor rules
    set nocompatible
    set bs=2
    set ruler
    set number
    syntax on

" Python syntax
    let python_highlight_all = 1

" Highlight search
    set hlsearch

" for God's sake, stop beeping
    set visualbell

" Tabs
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set smartindent
    set cindent
    set cinoptions=(0,u0,U0
    let g:indent_guides_start_level = 2

" Splits
    set splitbelow
    set splitright

" Make pane navigation easier
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Navigation with guides
    inoremap <Space><Space> <Esc>/<++><CR>:noh<CR>cf>
    vnoremap <Space><Space> <Esc>/<++><CR><Esc>:noh<CR>cf>
    map <Space><Space> <Esc>/<++><<CR>><Esc>:noh<CR>cf>
    inoremap ;gui <++>

" Navigate back to previous buffer
    map <Leader>p <Esc>:e#<CR>

" PHP specific snippets
    autocmd FileType php inoremap ;fe foreach ( <++> as <++>) {<++>}<Esc>F(i
    autocmd FileType php inoremap ;fr for ( <++>; <++>; <++>) {<++>}<Esc>F(i
    autocmd FileType php inoremap ;a array(<++>)<Esc>F(i
    autocmd FileType php inoremap ;cl class <++><CR>{<++>}<Esc>kTsi
    autocmd FileType php inoremap ;ce class <++> extends <++><CR>{<++>}<Esc>kTsi
    autocmd FileType php inoremap ;ci class <++> implements <++><CR>{<++>}<Esc>kTsi
    autocmd FileType php inoremap ;cei class <++> extends <++> implements <++><CR>{<++>}<Esc>kTsi
    autocmd FileType php inoremap ;if if ( <++>) {<++>}<Esc>F(i
    autocmd FileType php inoremap ;elif else if ( <++>) {<++>}<Esc>F(i
    autocmd FileType php inoremap ;else else {<++>}<Esc>F{i

" Colors
    set background=light
    try
    	colorscheme solarized
    catch
    endtry

    set t_Co=16

    call togglebg#map("<F5>")
