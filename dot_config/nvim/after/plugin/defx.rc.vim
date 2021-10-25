if !exists('g:loaded_defx') | finish | endif

" Define mappings
nnoremap <silent> <leader>f :Defx -listed -resume
  \ -columns=git:indent:icons:space:filename
  \ -ignored-files='.git*'
  \ -root-marker=''
  \ `escape(expand(getcwd()), ' :\')`<CR>
nnoremap <silent> <leader>dot :Defx -listed -resume
  \ -columns=git:indent:icons:space:filename
  \ -ignored-files='.git*'
  \ -root-marker=''
  \ `escape(expand($XDG_DATA_HOME), ' :\') . '/chezmoi'`<CR>

autocmd FileType defx call s:defx_my_settings()
  function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> c
      \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
      \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
      \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
      \ defx#do_action('open')
    nnoremap <silent><buffer><expr> o
      \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> nd
      \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> nf
      \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> nF
      \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
      \ defx#do_action('toggle_columns',
      \                'git:indent:icons:space:filename:size:time')
    nnoremap <silent><buffer><expr> d
      \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
      \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
      \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
      \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
      \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
      \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h
      \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> H
      \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
      \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
      \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
      \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
      \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
      \ line('.') == 1 ? 'G' : 'k'
    nnoremap <buffer><expr> <C-l>
      \ defx#do_action('redraw')
    nnoremap <buffer><expr> cd
	    \ defx#do_action('change_vim_cwd')
  endfunction

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

" set max width of filename column
call defx#custom#column('filename', {
  \ 'max_width': -20,
  \ })

" automatically redraw after files change
autocmd BufWritePost * call defx#redraw()
