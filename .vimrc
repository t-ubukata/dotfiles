scriptencoding utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" internal encoding
set encoding=utf-8
" detect Japanese encoding
set fileencodings=utf-8,utf-16,utf-16le,cp932,sjis,iso-2022-jp,euc-jp,latin1,utf-8
" not compatible with vi
set nocompatible
" tab width
set tabstop=2
" auto indent
set autoindent
" auto indent tab width
set shiftwidth=2
" expand tab to space
set expandtab
" not expand tab to space when editing makefile
autocmd FileType make setlocal noexpandtab
" press backspace to delete indent, eol, characters left of curosr
set backspace=indent,eol,start
" research again from head
set wrapscan
" command line extended mode
set wildmenu
" yank to clipboard
set clipboard+=unnamed
" ignore case to search
set ignorecase
" case sensitive when including upper and lower cases
set smartcase
" hilighting search
set hlsearch
" incremental search
set incsearch
" command history
set history=100
" key code time out
set ttimeout
" time out length (ms)
set ttimeoutlen=100
" not incliment and decliment octal
set nrformats-=octal
" screen setting
set number
set ruler
syntax on
" show tab, trailing whitespace, eol
set list
" replace tab, extends, trailing whitespace, non-breaking space with
set listchars=tab:>-,extends:<,trail:.,nbsp:.
" wrap off
set nowrap
" always show status line
set laststatus=2
" show command
set showcmd
" show title
set title
" hilight cursorline
set cursorline
" not make back up file
set nobackup
" not make undo file
set noundofile
" not make swap file
set noswapfile
" statusline
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%=[HEX=%02.2B]%-14.(%l,%c%V%) %p%%'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key bind
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <C-Space> to switch to normal mode
" <C-Space> is mapped to <nul>
noremap! <Nul> <Esc>

" gr to switch to left tab
nnoremap gr gT

" not replace paste buffer
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
" plugins
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
let NERDTreeShowHidden=1
