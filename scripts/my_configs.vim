" Fast Closing
nmap <leader>q :q<cr>

" Fast Writing
nmap <leader>w :w<cr>

" Fast Commands
nmap <leader>; :

" Fast Buffer Switch
nmap <ENTER> :bn<cr>

" Fast copy buffer to clipboard
nmap <leader>cp gg"*yG

" Fast Editing of this file
nmap <leader>ev :vsplit ~/.vim_runtime/my_configs.vim<cr>

" Opens a new file with the current buffer's path
" Super useful when editing files in the same directory
map <leader>ee :edit <c-r>=expand("%:p:h")<cr>/

" Show Line Numbers
set nu

" Map to removing trailing whitespace
nmap <leader>W :%s/\s\+$//e<cr>

autocmd BufNewFile,BufRead * setlocal formatoptions=croq

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" No need to use tabs when you can use buffers and buffer lists
set showtabline=0

autocmd FileType cpp setlocal commentstring=//%s

" Should look into why popup breaks ctrlp and preview breaks menu rerender
set completeopt-=preview

" No need to show mode again below status line
set noshowmode
