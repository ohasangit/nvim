let b:ale_linters = {'python': ['pylama', 'pyright', 'bandit']}
let b:ale_fixers = {'python': ['black', 'autopep8', 'reorder-python-imports']}

nmap <leader>ru :bo terminal ++rows=15 ++close python -i %<cr>
