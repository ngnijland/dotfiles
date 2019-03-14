syntax on

set hlsearch

set number

call plug#begin()

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" onedark for color theme
Plug 'joshdick/onedark.vim'

" vim-vinegar for directory browsing inside vim
Plug 'tpope/vim-vinegar'

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

Plug 'scrooloose/nerdcommenter'

" Code formatting and fixing
Plug 'w0rp/ale'
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 400

call plug#end()

" Color scheme
colorscheme onedark

" Enable anti alias
set antialias

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

