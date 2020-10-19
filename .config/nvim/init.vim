syntax on

set hlsearch

set number
set relativenumber

call plug#begin()

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'peitalin/vim-jsx-typescript'

" Color theme
Plug 'joshdick/onedark.vim'

" vim-vinegar for directory browsing inside vim
Plug 'tpope/vim-vinegar'
let g:netrw_keepdir = 0
let g:netrw_localrmdir='rm -r'

" Find root dir
Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

" status line
Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" Explore current project root
command! ProjectExplore exe 'Explore ' . FindRootDirectory()
nnoremap <leader>- :ProjectExplore <enter>

" vim-gitgutter for git diffs in files
Plug 'airblade/vim-gitgutter'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Elixir specifics
Plug 'slashmili/alchemist.vim'
let g:alchemist_tag_disable = 1

" Elixir specifics
Plug 'slashmili/alchemist.vim'
let g:alchemist_tag_disable = 1

" ALE configuration {{{1

" You have to use formatter from the root of the elixir project
" or to be precise from the folder where .formatter.exs file exist.
" Otherwise, formatter dependencies will not be used.

" Change working directory to directory where .formatter.exs exists, upwards.
fun! ALE_BEFORE_mix_format(bufnr)
	" find path of the .formatter.exs upwards from the current file
	let path = fnamemodify(findfile(".formatter.exs", expand("%:p:h").";"), ":p:h")
	exe 'lcd '. path
endfu

" Change working directory to directory of the current file
fun! ALE_AFTER_mix_format(bufnr)
	lcd %:p:h
endfu

" Code formatting and fixing
Plug 'w0rp/ale'

let g:ale_linters = {}
let g:ale_linters.elixir = ['credo']
let g:ale_linters.javascript = ['eslint']
let g:ale_linters['javascript.jsx'] = ['eslint']
let g:ale_linters.typescript = ['eslint', 'tslint']
let g:ale_linters['typescript.tsx'] = ['eslint', 'tslint']

let g:ale_fixers = {}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.elixir = ['ALE_BEFORE_mix_format', 'mix_format', 'ALE_AFTER_mix_format']
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers['javascript.jsx'] = ['prettier']
let g:ale_fixers.typescript = ['prettier']
let g:ale_fixers['typescript.tsx'] = ['prettier']
let g:ale_fixers.json = ['prettier']
let g:ale_fixers.css = ['prettier']

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 700

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['typescript-language-server',  '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server',  '--stdio'],
    \ 'typescript': ['typescript-language-server',  '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server',  '--stdio'],
    \ }

let g:LanguageClient_useFloatingHover=1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

set completeopt-=preview

" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#auto_complete_delay = 200
let g:deoplete#max_list = 30

let g:deoplete#sources = {}
let g:deoplete#sources['elixir'] = ['alchemist']
let g:deoplete#sources['javascript'] = ['LanguageClient_neovim']
let g:deoplete#sources['javascript.tsx'] = ['LanguageClient_neovim']
let g:deoplete#sources['typescript'] = ['LanguageClient_neovim']
let g:deoplete#sources['typescript.tsx'] = ['LanguageClient_neovim']

let g:deoplete#enable_at_startup = 1

autocmd FileType scheme
  \ call deoplete#custom#buffer_option('auto_complete', v:false)

" Use tab for autocomplete
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" Git wrapper
Plug 'tpope/vim-fugitive'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()

" Color scheme
colorscheme onedark

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
