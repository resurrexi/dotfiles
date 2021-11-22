" Trim whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Modify tab spacing for certain filetypes
augroup TabSpacing
  au!
  au FileType python setlocal shiftwidth=4 tabstop=4
  au FileType zsh setlocal shiftwidth=4 tabstop=4
  au FileType toml setlocal shiftwidth=4 tabstop=4
augroup end

" Recognize chezmoi and set post-save hook
augroup Chezmoi
  au!
  au BufEnter dot_zshrc.tmpl setf zsh
  au BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
augroup end

" Terminal load settings
augroup TerminalSettings
  au TermOpen * startinsert
  au TermOpen * setlocal nonumber
  au TermOpen * setlocal norelativenumber
  " Enter insert mode anytime when entering terminal
  au BufEnter * if &buftype == 'terminal' | startinsert | endif
augroup end

" Transparent bg
au SourcePost * hi Normal guibg=none ctermbg=none
  \ | hi LineNr guibg=none ctermbg=none
  \ | hi SignColumn guibg=none ctermbg=none
  \ | hi Comment guibg=none ctermbg=none
  \ | hi Constant guibg=none ctermbg=none
  \ | hi Special guibg=none ctermbg=none
  \ | hi Identifier guibg=none ctermbg=none
  \ | hi Statement guibg=none ctermbg=none
  \ | hi PreProc guibg=none ctermbg=none
  \ | hi Type guibg=none ctermbg=none
  \ | hi Underlined guibg=none ctermbg=none
  \ | hi Todo guibg=none ctermbg=none
  \ | hi String guibg=none ctermbg=none
  \ | hi Function guibg=none ctermbg=none
  \ | hi Conditional guibg=none ctermbg=none
  \ | hi Repeat guibg=none ctermbg=none
  \ | hi Operator guibg=none ctermbg=none
  \ | hi Structure guibg=none ctermbg=none
  \ | hi NonText guibg=none ctermbg=none
  \ | hi CursorLineNr guibg=none ctermbg=none
  \ | hi FloatBorder guibg=none ctermbg=none

" Auto-apply plugin changes
au BufWritePost plugins.lua source <afile> | PackerCompile
