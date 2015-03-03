set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/formatxml.vim
call vundle#begin()
     Plugin 'wincent/command-t'
     Plugin 'vtreeexplorer'
     Plugin 'scrooloose/syntastic' " check syntax
     Plugin 'MarcWeber/vim-addon-mw-utils' " snippets dependency
     Plugin 'tomtom/tlib_vim' " snippets dependency
     Plugin 'garbas/vim-snipmate' " snippets dependency
     Plugin 'honza/vim-snippets' " snippets
     Plugin 'mattn/emmet-vim' " emmet html building
     Plugin 'mileszs/ack.vim' " Project wide searching
     Plugin 'vim-scripts/AutoComplPop' " Auto Completion Popup
     Plugin 'altercation/vim-colors-solarized'
     Plugin 'bling/vim-airline' " bundle of features that can be seen here https://github.com/bling/vim-airline
     Plugin 'scrooloose/nerdtree'
     Plugin 'kchmck/vim-coffee-script'
     Plugin 'groenewege/vim-less' " sytax highlighting for less
     Plugin 'terryma/vim-multiple-cursors' " cursors
     Plugin 'tpope/vim-surround'
call vundle#end()            " required
     " Brief help
     " :PluginList       - lists configured plugins
     " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
     " :PluginSearch foo - searches for foo; append `!` to refresh local cache
     " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
     "
     " see :h vundle for more details or wiki for FAQ
     " Put your non-Plugin stuff after this line
  
filetype plugin indent on    " required
syntax on
set nu

" custom key bindings
map <C-t> <esc>:CommandT<Enter>
map <C-k> <esc>:NERDTreeToggle<CR>

command! -range=% FormatXML <line1>,<line2>call DoFormatXML()
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR> 

" give access to system keyboard
set clipboard=unnamed

" tab settings
set switchbuf=usetab
map <C-n> :tabnew<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR> there is some issue here

" set solarized theme
syntax enable
set background=dark
colorscheme solarized

" convert tabs to spaces and set tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Plugin 'bling/vim-airline' " status bar settings
set laststatus=2 " keep the status bar always on

" sytax highlighting
au BufReadPost *.sublime-snippet set syntax=xml
