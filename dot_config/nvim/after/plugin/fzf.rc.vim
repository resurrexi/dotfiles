if !exists('g:loaded_fzf') | finish | endif

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Preview window
let g:fzf_preview_window = ['right:50%:nohidden', 'f2']
" fzf layout: https://github.com/junegunn/fzf/blob/master/README-VIM.md#configuration
let g:fzf_layout = { 'down': '40%' }

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" Mapping selecting mappings
nmap <leader><Tab> <Plug>(fzf-maps-n)
xmap <leader><Tab> <Plug>(fzf-maps-x)
omap <leader><Tab> <Plug>(fzf-maps-o)

" Insert mode completion
inoremap <expr> <C-f><C-f> fzf#vim#complete#path('fd --hidden --exclude .git')
imap <C-f><C-l> <Plug>(fzf-complete-buffer-line)

" Additional custom mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
