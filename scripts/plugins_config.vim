""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-i> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_mruf_exclude = 'COMMIT_EDITMSG'
let g:ctrlp_mruf_max = 400

map <leader>f :CtrlPMRUFiles<cr>

let g:ctrlp_max_height = 20


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [[ 'lineinfo' ], [ 'percent' ], ['filetype'], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_removed = '-'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-auto-origami
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup autofoldcolumn
  au!

  " Or whatever autocmd-events you want
  au CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-auto-origami
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_browser = "firefox --new-window"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'

let ale_lint_on_insert_leave = 0
let ale_lint_on_text_changed = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabularize
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Examples of tabularize configurations. Function at the end auto tabs.

" if exists(":Tabularize")
"   nmap <Leader>a= :Tabularize /=<CR>
"   vmap <Leader>a= :Tabularize /=<CR>
"   nmap <Leader>a: :Tabularize /:\zs<CR>
"   vmap <Leader>a: :Tabularize /:\zs<CR>
" endif

" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_session_persistence = 1
