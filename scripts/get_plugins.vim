" Install vim-plug beforehand if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify a directory for plugins
call plug#begin('~/.vim/pack/plugins/start')

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
Plug 'tpope/vim-dispatch'
Plug 'maralla/completor.vim'
Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'morhetz/gruvbox', {'dir': '~/.vim/colors/gruvbox', 'rtp': 'colors', 'do': 'cp ~/.vim/colors/gruvbox/autoload/lightline/colorscheme/gruvbox.vim ~/.vim/pack/plugins/start/lightline.vim/autoload/lightline/colorscheme && cp ~/.vim/colors/gruvbox/colors/gruvbox.vim ~/.vim/colors/' }
" Expect to install fzf manually since it modifies your bashrc.
" Can make this part of vim's plugins if you want
Plug '~/source-install/fzf/', {'rtp': 'plugin', 'do': 'ln -s ~/source-install/fzf/ ~/.vim/pack/plugins/start/fzf'}

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
