call plug#begin('~/.local/share/nvim/plugged')

" Fugitive
Plug 'tpope/vim-fugitive'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'valloric/youcompleteme', {'do': './install.py --all'}

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

call plug#end()

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
:nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <space>r <Plug>(unite_restart)

vnoremap <silent> <Enter> :EasyAlign<cr>

let g:syntastic_php_checkers = ['php', 'phpcs']

let g:airline_theme='solarized'
let g:airline_powerline_fonts=1

""" Personal
set nocompatible
set bs=2
set ruler
syntax on

set hlsearch
set visualbell " for God's sake, stop beeping

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

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Colors
set background=light

try
	colorscheme solarized
catch
endtry
