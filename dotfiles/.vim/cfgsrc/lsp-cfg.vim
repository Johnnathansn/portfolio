" VIM-LSP

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    "nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gd :tab LspDefinition<cr>
    nmap <buffer> <leader>gs <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>[g <plug>(lsp-previous-diagnostics)
    nmap <buffer> <leader>]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>K <plug>(lsp-hover)
    "nmap <buffer> <leader> <expr><c-f> lsp#scroll(+4)
    "nmap <buffer> <leader> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" PHP
if executable('intelephense')
    augroup LspPHPIntelephense
        au!
        au User lsp_setup call lsp#register_server({
            \    'name': 'intelephense',
            \    'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
            \    'whitelist': ['php'],
            \    'initialization_options': {'storagePath': '/tmp/intelephense/'},
            \    'settings': {
            \          'intelephense': {
            \              'files': {
            \                  'maxSize': 1000000,
            \                  'associations': ['*.php', '*.phtml'],
            \                  'exclude': [],
            \              },
            \              'completion': {
            \                  'insertUseDeclaration': v:true,
            \                  'fullyQualifyGlobalConstantsAndFunctions': v:false,
            \                  'triggerParameterHints': v:true,
            \                  'maxItems': 100,
            \              },
            \              'format': {
            \                  'enale': v:true
            \              }
            \          }
            \    }
            \ })
    augroup END
endif

" GO
"augroup LspGo
"    au!
"    autocmd User lsp_setup call lsp#register_server({
"        \'name': 'go-lang',
"        \'cmd': {server_info->['gopls']},
"        \'whitelist': ['go'],
"        \})
"    autocmd FileType go setlocal omnifunc=lsp#complete
"    "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
"    "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"    "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error
"augroup END
