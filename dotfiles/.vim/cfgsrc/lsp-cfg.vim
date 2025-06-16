" VIM-LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>gd <plug>(lsp-definition)
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
    nmap <buffer> <leader>P <plug>(lsp-code-action-float)

    nmap <expr><buffer> <c-f> popup_list()->empty() ? '<c-f>' : lsp#scroll(+4)
    nmap <expr><buffer> <c-d> popup_list()->empty() ? '<c-d>' : lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.go call execute('LspDocumentFormatSync') | call execute('LspCodeActionSync source.organizeImports')
    autocmd! BufWritePre *.cpp,*.c,*.cxx,*.h,*.hpp call execute('LspDocumentFormatSync')
    autocmd! BufWritePre *.vue call execute('LspDocumentFormatSync')
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
if executable('gopls')
    augroup LspGo
        au!
        autocmd User lsp_setup call lsp#register_server({
            \'name': 'gopls',
            \'cmd': {server_info->['gopls']},
            \'whitelist': ['go'],
            \})
        autocmd FileType go setlocal omnifunc=lsp#complete
    augroup END
endif

" CPP
if executable('clangd')
    autocmd FileType cpp,c,objc,objcpp setlocal omnifunc=lsp#complete
endif

" Typescript, JS, React, Vue
autocmd FileType vue let g:lsp_settings_filetype_vue = ["volar-server","typescript-language-server"]
