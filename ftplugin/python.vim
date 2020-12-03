let b:ale_linters = {'python': ['pylama', 'pyright', 'bandit']}
let b:ale_fixers = {'python': ['black', 'autopep8', 'reorder-python-imports']}
let g:ale_python_black_options = '--line-length 79'

nmap <leader>ru :bo terminal ++rows=15 ++close python -i %<cr>
setlocal tw=79
setlocal fo+=t
