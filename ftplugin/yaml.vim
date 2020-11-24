nmap <leader>ru :bo terminal ++rows=15 ++hidden ++open gitlab-ci-linter.linux-386 --gitlab-url https://gitlab.us.lmco.com --verbose %<cr>
let b:ale_fixers = {'yaml': [ 'prettier' ]}
