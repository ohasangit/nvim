let b:ale_linters = {'python': ['pylama', 'pyright', 'bandit']}
let b:ale_fixers = {'python': ['black', 'autopep8', 'reorder-python-imports']}
let g:ale_python_black_options = '--line-length 79'

nmap <leader>ru :T python -i %<cr>
setlocal textwidth=79
setlocal formatoptions+=t
