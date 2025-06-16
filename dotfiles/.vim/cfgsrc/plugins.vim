" Plugins 
call plug#begin()

" colorschemes
Plug 'sainnhe/sonokai'
Plug 'ghifarit53/tokyonight-vim' 
Plug 'morhetz/gruvbox/'

" plugins

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

" Go syntax highlighting
Plug 'charlespascoe/vim-go-syntax'

" Outline bar
Plug 'liuchengxu/vista.vim'

" Git Fugitive
Plug 'tpope/vim-fugitive'

" AI Codeium
Plug 'exafunction/codeium.vim', {'branch': 'main'}

call plug#end()
