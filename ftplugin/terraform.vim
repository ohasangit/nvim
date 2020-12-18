nmap <leader>ti :bo terminal ++rows=15 ++open terraform init <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>ta :bo terminal ++rows=15 ++open terraform apply <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>td :bo terminal ++rows=15 ++open terraform destroy <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>tv :bo terminal ++rows=15 ++open terraform validate <c-r>=expand("%:p:h")<cr>/<cr>
let b:ale_fixers = {'terraform': [ 'terraform' ]}
