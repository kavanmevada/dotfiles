call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

Plug 'kyazdani42/nvim-web-devicons'
Plug 'morhetz/gruvbox'

call plug#end()


set encoding=utf-8
set fileencoding=utf-8
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set mouse=a
set keymodel=startsel,stopsel

" copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>


set encoding=UTF-8

syntax on
colorscheme gruvbox

let g:gruvbox_contrast_dark='hard'
hi! link Function GruvboxYellow




nnoremap <C-t> <cmd>CHADopen<cr>

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
vim.cmd('COQnow -s')


EOF
