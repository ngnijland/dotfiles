syntax on

set hlsearch

set number
set relativenumber

call plug#begin()
" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['typescript-language-server',  '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server',  '--stdio'],
    \ 'javascriptreact': ['typescript-language-server',  '--stdio'],
    \ 'typescript': ['typescript-language-server',  '--stdio'],
    \ 'typescriptreact': ['typescript-language-server',  '--stdio'],
    \ }

let g:LanguageClient_useFloatingHover=1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

set completeopt-=preview

" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#option = {}
let g:deoplete#option['elixir'] = ['alchemist']
let g:deoplete#option['javascript'] = ['LanguageClient_neovim']
let g:deoplete#option['javascript.tsx'] = ['LanguageClient_neovim']
let g:deoplete#option['typescript'] = ['LanguageClient_neovim']
let g:deoplete#option['typescript.tsx'] = ['LanguageClient_neovim']

let g:deoplete#enable_at_startup = 1

autocmd FileType scheme
  \ call deoplete#custom#buffer_option('auto_complete', v:false)
  \ call deoplete#custom#option({
  \ 'auto_complete_delay': 200,
  \ 'max_list': 30,
  \ })

" Use tab for autocomplete
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"


" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" vim-vinegar for directory browsing inside vim
Plug 'tpope/vim-vinegar'
let g:netrw_keepdir = 0
let g:netrw_localrmdir='rm -r'

" Find root dir
Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

" Explore current project root
command! ProjectExplore exe 'Explore ' . FindRootDirectory()
nnoremap <leader>- :ProjectExplore <enter>

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
command! ProjectFiles exe 'Files ' . FindRootDirectory()
nnoremap <leader>p :ProjectFiles <enter>

" Make sure ag ignores file names
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \ {'options': '--delimiter : --nth 4..'}, <bang>0)

" Code formatting and fixing
Plug 'w0rp/ale'

let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint']
let g:ale_linters['javascript.jsx'] = ['eslint']
let g:ale_linters.javascriptreact = ['eslint']
let g:ale_linters.typescript = ['eslint', 'tslint']
let g:ale_linters['typescript.tsx'] = ['eslint', 'tslint']
let g:ale_linters.typescriptreact = ['eslint', 'tslint']

let g:ale_fixers = {}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers['javascript.jsx'] = ['prettier']
let g:ale_fixers.javascriptreact = ['prettier']
let g:ale_fixers.typescript = ['prettier']
let g:ale_fixers['typescript.tsx'] = ['prettier']
let g:ale_fixers.typescriptreact = ['prettier']
let g:ale_fixers.json = ['prettier']
let g:ale_fixers.css = ['prettier']
let g:ale_fixers.scss = ['prettier']

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 700

" Color theme
Plug 'joshdick/onedark.vim'

" status line
Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" vim-gitgutter for git diffs in files
Plug 'airblade/vim-gitgutter'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Code stats
Plug 'wakatime/vim-wakatime'
call plug#end()


" Color scheme
colorscheme onedark

set completeopt-=preview

" Expand tabs to spaces
set expandtab

set tabstop=2
" Soft-Tabs should be 2 spaces
set softtabstop=2
" When shifting, use 2 spaces
set shiftwidth=2

" Set backspace to indent,eol,start
set bs=2

set termguicolors

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
