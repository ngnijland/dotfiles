syntax on

set hlsearch

set number
set relativenumber

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'peitalin/vim-jsx-typescript'

" onedark for color theme
Plug 'joshdick/onedark.vim'

" Solarized color theme
Plug 'lifepillar/vim-solarized8'

" vim-vinegar for directory browsing inside vim
Plug 'tpope/vim-vinegar'
let g:netrw_keepdir = 0
let g:netrw_localrmdir='rm -r'

" Find root dir
Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
command! ProjectFiles exe 'Files ' . FindRootDirectory()
nnoremap <leader>p :ProjectFiles <enter>

" Make sure ag ignores file names
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \ {'options': '--delimiter : --nth 4..'}, <bang>0)

" status line
Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" vim-gitgutter for git diffs in files
Plug 'airblade/vim-gitgutter'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Elixir specifics
Plug 'slashmili/alchemist.vim'
let g:alchemist_tag_disable = 1

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
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['tsserver', 'eslint'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'elixir': ['ALE_BEFORE_mix_format', 'mix_format', 'ALE_AFTER_mix_format'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 400

" Use tab for autocomplete
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" Git wrapper
Plug 'tpope/vim-fugitive'

" Language client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'reason': ['~/reason-language-server.exe'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server', '--stdio']
    \ }

let g:LanguageClient_useFloatingHover=1

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

set completeopt-=preview

" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#auto_complete_delay = 20
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

call plug#end()

" Background for solarized theme
" set background=light

" Color scheme
colorscheme onedark
" colorscheme solarized8

" Expand tabs to spaces
set expandtab

set tabstop=2
" Soft-Tabs should be 2 spaces
set softtabstop=2
" When shifting, use 2 spaces
set shiftwidth=2

" Set backspace to indent,eol,start
set bs=2

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Enable 24bit true colors
if (empty($TMUX))
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" ARROW KEYS ARE UNACCEPTABLE
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
