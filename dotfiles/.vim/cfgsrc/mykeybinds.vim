
" disable search highlight
nnoremap <leader><space> :nohlsearch<CR>

" space open/closes folds
nnoremap <space> za

" NERDTree setup
" keymap open NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Asyncomplete.vim
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
