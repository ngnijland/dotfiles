syntax on

set hlsearch

set number
set relativenumber

call plug#begin()

set completeopt-=preview

Plug 'neoclide/coc.nvim', {'branch': 'release'}

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#insert() : "\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gv :rightbelow vsplit<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Color theme
Plug 'joshdick/onedark.vim'
" Plug 'lifepillar/vim-solarized8'

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

call plug#end()

" Enforce filetypes for extentions
autocmd BufNewFile,BufRead *.mjml set filetype=xml

" Color scheme
" colorscheme onedark
set background=light
autocmd vimenter * ++nested colorscheme onedark

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
