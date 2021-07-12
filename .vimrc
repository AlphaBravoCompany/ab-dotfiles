" Turn on syntax highlighting.
syntax on

" Display options
set encoding=utf-8
set showmode
set showcmd
set modeline
set ruler
set number
set matchpairs+=<:>
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set linebreak
set showbreak=▹
set scrolloff=5
set backspace=indent,eol,start
set history=50

" Change the cursor at insert mode
let &t_ti.="\<Esc>[1 q"
let &t_SI.="\<Esc>[5 q"
let &t_EI.="\<Esc>[1 q"
let &t_te.="\<Esc>[0 q"

