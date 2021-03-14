nmap <leader>ti :T terraform init <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>ta :T terraform apply <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>td :T terraform destroy <c-r>=expand("%:p:h")<cr>/<cr>
nmap <leader>tv :T terraform validate <c-r>=expand("%:p:h")<cr>/<cr>
let b:ale_fixers = {'terraform': [ 'terraform' ]}
