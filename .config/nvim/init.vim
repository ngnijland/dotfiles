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
