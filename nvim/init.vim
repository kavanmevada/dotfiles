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


" Switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-W> :tabclose<CR>

inoremap " ""<left>

" Map ctrl+S to save
inoremap <c-s> <cmd>:w<cr>
nnoremap <c-s> <cmd>:w<cr>


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
