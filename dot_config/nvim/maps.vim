" Description: Keymaps

" set leader key
let mapleader = ","

" delete without registering
nnoremap x "_x
nnoremap X "_X

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Split window
noremap <C-w><C-d> :new<CR>
noremap <C-w><C-r> :vnew<CR>

" resize window
noremap <C-w><C-left> <C-w><
noremap <C-w><C-right> <C-w>>
noremap <C-w><C-up> <C-w>+
noremap <C-w><C-down> <C-w>-

" clear highlighted text
nnoremap <Esc><Esc> :noh<CR>

