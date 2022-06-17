call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'franbach/miramare'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()


lua << EOF
local nvim_lsp = require('lspconfig')
local coq = require('coq')

nvim_lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
  settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}))

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

vim.cmd('COQnow -s')
EOF


set hidden
set expandtab ts=4 sw=4 ai
set completeopt=menuone,noinsert
set number
set mouse=a
set keymodel=startsel,stopsel
set clipboard=unnamedplus

let g:coq_settings = { 'display.icons.mode': 'none' }



let g:rustfmt_autosave = 1


syntax enable
filetype plugin indent on
colorscheme miramare
highlight MatchParen gui=bold guibg=NONE cterm=bold ctermbg=NONE


" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

inoremap <silent> <C-a> <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <C-a> <cmd>lua vim.lsp.buf.code_action()<CR>

inoremap <C-P> <C-\><C-O>:call CocActionAsync('showSignatureHelp')<cr>



inoremap " ""<left>

" Map ctrl+S to save
inoremap <c-s> <cmd>:w<cr>
nnoremap <c-s> <cmd>:w<cr>



" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>  


:map <C-Q> <ESC>:qa!<CR>
:imap <C-Q> <ESC>:qa!<CR>
:map <C-X> <ESC>:x<CR>
:imap <C-X> <ESC>:x<CR>


:map <F5> <ESC>:!cargo run<CR>
:map <F6> <ESC>:!cargo test<CR>
:imap <F5> <ESC>:!cargo run<CR>
:imap <F6> <ESC>:!cargo test<CR>
