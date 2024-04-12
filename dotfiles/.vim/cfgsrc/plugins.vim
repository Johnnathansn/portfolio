
" Plugins 
call plug#begin()

" colorschemes
Plug 'sainnhe/sonokai'
Plug 'ghifarit53/tokyonight-vim' 

" plugins

"file management
Plug 'scrooloose/nerdtree' 

" Debug
Plug 'puremourning/vimspector'

" file search
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()
