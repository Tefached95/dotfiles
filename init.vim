call plug#begin('~/.local/share/nvim/plugged')

" Fugitive
Plug 'tpope/vim-fugitive'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Autocomplete
" Plug 'valloric/youcompleteme', {'do': './install.py --all'}
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/python-support.nvim'
Plug 'ervandew/supertab'

" Auto closing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

" NERD tree
Plug 'scrooloose/nerdtree'

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
Plug 'roxma/ncm-phpactor'
Plug 'phpactor/phpactor'

" Refactoring tools
Plug 'adoy/vim-php-refactoring-toolbox'

" Colors
Plug 'altercation/vim-colors-solarized'

call plug#end()

" Leader key map
    :let mapleader = ";"

" Vim Gutentags
    let g:gutentags_project_root = [ '~/Documents/adomee' ]

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
    vnoremap <silent> <Enter> :EasyAlign<cr>

" PHP Stuff
    let g:syntastic_php_checkers = ['php', 'phpcs']

" Phpactor stuff
    let g:phpactorPhpBin = "/usr/bin/php"
    let g:phpactorOmniError = v:true
    autocmd FileType php setlocal omnifunc=phpactor#Complete

" Context menu
    nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Class/member definition navigation
    nmap <Leader>o yiw:tag <C-R>"<CR>

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

" Splits
    set splitbelow
    set splitright
" Make pane navigation easier
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

" Navigation with guides
    inoremap <Space><Tab> <Esc>/<++><Enter>df>i
    vnoremap <Space><Tab> <Esc>/<++><Enter><Esc>df>i
    map <Space><Tab> <Esc>/<++><Enter><Esc>df>i
    inoremap ;gui <++>

" PHP specific snippets
    autocmd FileType php inoremap ;fe foreach<Space>( <++> as <++>)<Space>{<++>}<Esc>F(i
    autocmd FileType php inoremap ;fr for<Space>( <++>; <++>; <++>)<Space>{<++>}<Esc>F(i
    autocmd FileType php inoremap ;a array(<++>)<Esc>F(i

" Colors
set background=light

try
	colorscheme solarized
catch
endtry

set t_Co=16

call togglebg#map("<F5>")
