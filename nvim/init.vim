call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" Some color scheme other then default
Plug 'franbach/miramare'

call plug#end()

syntax enable
filetype plugin indent on
colorscheme miramare

" Configure lsp

lua <<EOF
-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }

)
EOF

set hidden
set expandtab ts=4 sw=4 ai
set completeopt=menuone,noinsert
set number
set mouse=a
set keymodel=startsel,stopsel
set clipboard=unnamedplus

let g:rustfmt_autosave = 1


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


" Switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-W> :tabclose<CR>



" Map ctrl+S to save
inoremap <c-s> <cmd>:w<cr>
nnoremap <c-s> <cmd>:w<cr>

" All buffer to tab view
:au BufAdd,BufNewFile,BufRead * nested tab sball


" autoclose braces
function! ConditionalPairMap(open, close)
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')
