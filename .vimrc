set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview'
"Plugin 'jalvesaq/R-Vim-runtime'
Plugin 'jalvesaq/Nvim-R'
"for python
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'vim-scripts/indentpython.vim'
"Plugin 'scrooloose/syntastic'
"Bundles
Bundle 'vim-scripts/guifontpp.vim'
"python
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'vim-scripts/Vim-R-plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
"
"
" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*
"
" " OPTIONAL: This enables automatic indentation as you type.
filetype indent on
"
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
" to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
 let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" " of indentation.
set sw=2
" " TIP: if you write your \label's as \label{fig:something}, then if you
" " type in \ref{fig: and press <C-n> you will automatically cycle through
" " all the figure labels. Very useful!
set iskeyword+=:
let g:livepreview_previewer = 'okular'
set t_Co=256
let g:Tex_DefaultTargetFormat = 'pdf'
:map <F6> :setlocal spell! spelllang=en_US<CR>

" Font change for GVIM
set guifont=Ubuntu\ Mono\ 14
set nu
colorscheme wombat256

" Settings for vim R plugin
" R script settings

   " Minimum required configuration: FOR Vim-R
   set nocompatible
   syntax on
   filetype plugin on
   filetype indent on

   " Change Leader and LocalLeader keys:
   let maplocalleader = ","
   let mapleader = ";"

   " Use Ctrl+Space to do omnicompletion:
   if has("gui_running")
       inoremap <C-Space> <C-x><C-o>
   else
       inoremap <Nul> <C-x><C-o>
   endif

   " Press the space bar to send lines and selection to R:
   vmap <Space> <Plug>RDSendSelection
   nmap <Space> <Plug>RDSendLine

   " The lines below are suggestions for Vim in general and are not
   " specific to the improvement of the Vim-R-plugin.

   " Highlight the last searched pattern:
   set hlsearch

   " Show where the next pattern is as you type it:
   set incsearch

   " By default, Vim indents code by 8 spaces. Most people prefer 4
   " spaces:
   set sw=4

   " Search "Vim colorscheme 256" in the internet and download color
   " schemes that supports 256 colors in the terminal emulator. Then,
   " uncomment the code below to set you color scheme:
   "colorscheme not_defined

" <Ctrl-l> redraws the screen and removes any search highlighting.
 nnoremap <silent> <C-l> :nohl<CR><C-l>

" Set Max line length to 80 characters
"set tw=80
"
"Allow R to run in a splitpane
let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1
let R_vsplit = 1
let R_specialplot = 1
let R_pdfviewer = "okular"

set backspace=indent,eol,start

"all the following is for python setup copied from real python
"split naviatgion control + vim navigator for lines
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" show folded docstrings
"let g:SimpylFold_docstring_preview=1

"PEP8 indentation for python
"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix

"flag whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"maybe include the following only if issues with utf
"set encoding=utf-8

"define python interpreter
"let g:python_host_prog='/usr/bin/python2.7'

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
"highlightin for python
"let python_highlight_all=1
"syntax on
