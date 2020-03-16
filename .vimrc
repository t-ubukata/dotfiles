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
" No compatible with vi.
set nocompatible
" Tab width.
set tabstop=2
" Auto indent.
set autoindent
" Auto indent tab width.
set shiftwidth=2
" Expand tab to space.
set expandtab
" Not expand tab to space when editing makefile.
autocmd FileType make setlocal noexpandtab
" Press backspace to delete indent, eol, characters left of curosr.
set backspace=indent,eol,start
" Research again from head.
set wrapscan
" Command line extended mode.
set wildmenu
" Yank to the clipboard.
set clipboard+=unnamed
" Ignore case to search.
set ignorecase
" Search case-sensitively when including upper and lower cases.
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
" Not incliment and decliment octal.
set nrformats-=octal
" show tab, trailing whitespace, eol.
set list
" Replace tab, extends, trailing whitespace, non-breaking space.
set listchars=tab:>-,extends:<,trail:.,nbsp:.
" Always show status line.
set laststatus=2
" Not make back up file.
set nobackup
" Not make undo file.
set noundofile
" Not make swap file.
set noswapfile
" Not warn when changing buffer.
set hidden
" Disable concealing.
set conceallevel=0
" Status line.
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline = '%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%=[HEX=%02.2B]%-14.(%l,%c%V%) %p%%'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Go back to normal mode.
noremap <C-j> <Esc>
noremap! <C-j> <Esc>

" gr to switch to the left tab.
nnoremap gr gT

" Not replace the paste buffer.
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
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeSortOrder = []

" vim-json
let g:vim_json_syntax_conceal = 0
