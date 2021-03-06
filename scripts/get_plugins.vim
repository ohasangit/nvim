" Install vim-plug beforehand if not installed
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify a directory for plugins
call plug#begin('$XDG_CONFIG_HOME/nvim/pack/plugins/start')

" Make sure you use single quotes

" Shorthand notation
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'benknoble/vim-auto-origami'
Plug 'suan/vim-instant-markdown'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'itchyny/lightline.vim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-startify'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/vim-plug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'gotcha/vimpdb'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'morhetz/gruvbox', {'dir': '$XDG_CONFIG_HOME/nvim/colors/gruvbox', 'rtp': 'colors', 'do': 'cp $XDG_CONFIG_HOME/nvim/colors/gruvbox/autoload/lightline/colorscheme/gruvbox.vim $XDG_CONFIG_HOME/nvim/pack/plugins/start/lightline.vim/autoload/lightline/colorscheme && cp $XDG_CONFIG_HOME/nvim/colors/gruvbox/colors/gruvbox.vim $XDG_CONFIG_HOME/nvim/colors/' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'kassio/neoterm'

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
