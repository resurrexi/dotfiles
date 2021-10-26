" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

syntax on
set nocompatible
set number
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set background=dark
set nobackup
set hlsearch
set ignorecase
set incsearch
set smarttab
set showcmd
set cmdheight=1
set laststatus=2
set expandtab
set splitright
set splitbelow
set shell=zsh
set scrolloff=10

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=*.pyc
set wildignore+=**/build/*
set wildignore+=**/coverage/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" Highlights
" ---------------------------------------------------------------------
"set cursorline
" Set cursor line color on visual mode
"highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
"highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

"augroup BgHighlight
"  autocmd!
"  autocmd WinEnter * set cul
"  autocmd WinLeave * set nocul
"augroup END

"if &term =~ "screen"
"  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
"  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
"endif

" File types "
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" chezmoi zshrc template
au BufNewFile,BufRead dot_zshrc.tmpl setf zsh

set suffixesadd+=.js,.es,.jsx,.json,.css,.less,.sass,.php,.py,.md

autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType zsh setlocal shiftwidth=4 tabstop=4
autocmd FileType toml setlocal shiftwidth=4 tabstop=4

" Imports
" ---------------------------------------------------------------------
" need to create prefix for fzf commands, https://github.com/junegunn/fzf.vim#commands
let g:fzf_command_prefix = 'Fzf'

runtime ./plug.vim
runtime ./maps.vim

" Syntax theme
" ---------------------------------------------------------------------
set t_Co=256
set background=dark
colorscheme PaperColor

" transparent bg
autocmd SourcePost * hi Normal guibg=none ctermbg=none
  \ | hi LineNr guibg=none ctermbg=none
  \ | hi SignColumn guibg=none ctermbg=none

" allow local project config
set exrc

" run chezmoi apply whenever you save a dotfile
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
" trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
