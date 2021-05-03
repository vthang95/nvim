filetype plugin on
filetype plugin indent on

syntax on

set encoding=UTF-8
set autoread

set hlsearch " Highlight search
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set updatetime=100

set list listchars=tab:▸\ ,eol:$,trail:·
highlight SpecialKey ctermfg=red guifg=#ff0000
highlight NonText guifg=#d9d9d9

" Enable true colors support
if (has("termguicolors"))
 set termguicolors
endif

set termguicolors     " enable true colors support
set background="dark
set number
colorscheme palenight

""""""""""""""""""""""""""""""""""""""""""" MAPPINGS

" Remove search highlight
map <leader>ok :noh<cr>

" Navigate views
map <leader><up> <C-w><up>
map <leader><down> <C-w><down>
map <leader><left> <C-w><left>
map <leader><right> <C-w><right>

" Shrink view
map + :vertical resize +5<cr>
map _ :vertical resize -5<cr>

" Quit current buffer
map <leader>q <C-w>q<cr>

" jump to the first non-blank character of the line
map < ^
" jump to the end of the line
map > $

" Split view
map <leader>hs :split<cr>
map <leader>vs :vsplit<cr>

" Open new tab
map <leader>tn :tabnew<cr>:GFiles<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Move lines
vnoremap <leader>k :m '<-2<cr>gv=gv
vnoremap <leader>j :m '>+1<cr>gv=gv
map <leader>j  :m .+1<cr>==
map <leader>k  :m .-2<cr>==

" Disable copy when delete
vnoremap d "_d
nnoremap xx dd
nnoremap dd "_dd
nnoremap fw dw
noremap dw "_dw

" Move cursor faster
map <S-j> 5j
map <S-k> 5k
map <S-h> b
map <S-l> w

" Set terminals to split below and right
set splitbelow
set splitright

" Settings for Coc
hi CocErrorLine guifg=#000000 guibg=#D25972
hi CocWarningLine guifg=#000000 guibg=#CBAC62
