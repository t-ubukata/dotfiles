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

" <C-j> to Return to normal mode.
noremap <C-j> <Esc>
noremap! <C-j> <Esc>

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
let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'junegunn/fzf.vim'
Jetpack 'preservim/nerdtree'
Jetpack 'tomtom/tcomment_vim'
Jetpack 'vim-airline/vim-airline'
Jetpack 'ConradIrwin/vim-bracketed-paste'
Jetpack 't-ubukata/vim-fswitch'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'elzr/vim-jsona'
Jetpack 'prabirshrestha/vim-lsp'
Jetpack 'mattn/vim-lsp-settings'
Jetpack 'dense-analysis/ale'

call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-lsp
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_diagnostics_enabled = 0
noremap <Space>j :LspDefinition <CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project setting.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:project_setting = expand("./.private.vim")
if filereadable(s:project_setting)
  source `=s:project_setting`
endif
