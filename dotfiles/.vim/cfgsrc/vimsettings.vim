
# tab settings
set tabstop=4			# number of visual spaces for TAB
set softtabstop=4		# number of spaces in TAB when editing
set expandtab			# tab are spaces
set shiftwidth=4        # indent correspont to single tab

set number				# show line numbers
set relativenumber      # show line relative number
set showcmd				# show command in bottom bar
set cursorline          # highlight current line
set showmatch           # highlight matching [{()}]
set nowrap              # no line wrapping
set wildmenu            # visual autocomplete for command menu
set title               # title with name of file

# vim files options
set backup
set backupdir=$HOME/.vim/tmp/backupfiles
set swapfile
set directory=$HOMR/.vim/tmp/swapfiles
set undofile
set undodir=$HOME/.vim/tmp/undofiles
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

# search settings
set incsearch           # search as characters are entered
set hlsearch            # highlight matches
set ignorecase          # case insensitive search
set smartcase           # smart case sensitive

# folding settings
set foldenable          # enable folding
set foldlevelstart=10   # open most folds by default
set foldnestmax=10      # 10 nested fold max
set foldmethod=indent   # fold based on indent level

# enable syntax processing
syntax on
filetype plugin indent on
#set omnifunc=syntaxcomplete#Complete

# Tags settings
set tags+=~/.vim/tags/tags

# bell off in windows ANNOYINNNNG
set belloff=all

# Extra settings to get colors in vim/tmux
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"  
set t_Co=256

# Important
if has('termguicolors')
	set termguicolors
endif
