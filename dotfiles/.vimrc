" Vim Variables

" tab settings
set tabstop=4			" number of visual spaces for TAB
set softtabstop=4		" number of spaces in TAB when editing
set expandtab			" tab are spaces
set shiftwidth=4        " indent correspont to single tab

set number				" show line numbers
set relativenumber      " show line relative number
set showcmd				" show command in bottom bar
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set nowrap              " no line wrapping
set wildmenu            " visual autocomplete for command menu
set title               " title with name of file


" search settings
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " case insensitive search
set smartcase           " smart case sensitive

" folding settings
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" key mappings
" disable search highlight
nnoremap <leader><space> :nohlsearch<CR>

" space open/closes folds
nnoremap <space> za

" enable syntax processing
syntax on
filetype plugin indent on
"set omnifunc=syntaxcomplete#Complete

" Tags settings
set tags+=~/.vim/tags/tags

" bell off in windows ANNOYINNNNG
set belloff=all

" Plugins 
call plug#begin()

" colorschemes
Plug 'sainnhe/sonokai'
Plug 'ghifarit53/tokyonight-vim' 

" plugins
Plug 'scrooloose/nerdtree' 
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jayli/vim-easycomplete'
Plug 'SirVer/ultisnips'
"Plug 'dense-analysis/ale'
call plug#end()

" Extra settings to get colors in vim/tmux
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"  
set t_Co=256

" Important
if has('termguicolors')
	set termguicolors
endif

" ALE settings
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

" EasyComplete settings
let g:easycomplete_tab_trigger = "<c-space>"
let easycomplete_scheme = "rider"
let g:easycomplete_diagnostics_enable = 1

" tokyonight configurations
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

" sonokai configurations
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

" colorscheme selection
colorscheme sonokai

" NERDTree setup
" keymap open NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
