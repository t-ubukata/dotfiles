scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Screen settings.
set number
set ruler
syntax on
set nowrap
set showcmd
set title
set cursorline
" Internal encoding.
set encoding=utf-8
" File encoding.
set fileencoding=utf-8
" File encodings to try form left to right.
set fileencodings=utf-8,cp932,sjis,iso-2022-jp,euc-jp
" No compatible with vi.
set nocompatible
" Tab width.
set tabstop=2
" Auto indent.
set autoindent
" Auto indent tab width.
set shiftwidth=2
" Expands tab to space.
set expandtab
" No expand tab to space in Makefile.
autocmd FileType make setlocal noexpandtab
" Backspace to delete indent, eol, characters left of curosr.
set backspace=indent,eol,start
" Wrap search.
set wrapscan
" Command line extended mode.
set wildmenu
" Yanks to clipboard.
set clipboard+=unnamed
" Ignores case to search.
set ignorecase
" Searchs case-sensitively when including upper and lower cases.
set smartcase
" Hilight search.
set hlsearch
" Incremental search.
set incsearch
" Command history.
set history=10000
" Key code time out.
set ttimeout
" Time out length (ms).
set ttimeoutlen=100
" No increment and decrement octal.
set nrformats-=octal
" Shows tab, trailing whitespace, eol.
set list
" Replaces tab, extends, trailing whitespace, non-breaking space.
set listchars=tab:>-,extends:<,trail:.,nbsp:.
" Always shows status line.
set laststatus=2
" No back up file.
set nobackup
" No undo file.
set noundofile
" No swap file.
set noswapfile
" No warn when changing buffer.
set hidden
" No concealing.
set conceallevel=0
" No modeline.
set nomodeline
" No bell.
set belloff=all

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the black hole register when using these change commands.
noremap c "_c
noremap cc "_cc
noremap C "_C
noremap s "_s
noremap S "_S
noremap r "_r
noremap R "_R
noremap cw "_cw

" <C-Space> to Return to normal mode.
if has('win64')
  noremap <C-Space> <Esc>
  noremap! <C-Space> <Esc>
else
  " Remaps <Nul> to <Esc> because <C-Space> sends <Nul> in Unix terminal.
  noremap <Nul> <Esc>
  noremap! <Nul> <Esc>
endif

" gr to switch to the left tab.
nnoremap gr gT

" No replace register when pasting 
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gtags.vim
noremap <Space>h :Gtags -f %<CR>
noremap <Space>j :GtagsCursor<CR>
noremap <Space>n :cn<CR>
noremap <Space>p :cp<CR>

" gen_tags.vim
let g:gen_tags#gtags_auto_gen = 1
let g:gen_tags#use_cache_dir = 0

" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeSortOrder = []

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-airline
let nl = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
let g:airline_section_y = '%{(&fenc!=""?&fenc:&enc)}[%{nl[&ff]}]'

" vim-airline-themes
" let g:airline_theme = 'solarized'
" let g:airline_solarized_bg = 'dark'
