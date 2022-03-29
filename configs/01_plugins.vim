call plug#begin('~/.config/nvim/plugins')

" Common plugs
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'vim-airline/vim-airline'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ervandew/supertab'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'mxw/vim-jsx'

" Elixir plugs
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" Js/Ts plugs
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'

call plug#end()

let mapleader = " "

" Settings for vim mix format
let g:mix_format_on_save = 1

" Settings for Vim Airline
let g:airline_powerline_fonts = 1
set hidden
let g:Powerline_symbols = 'fancy'
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme='onehalfdark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" Settings for NERDTree
let NERDTreeIgnore = ['\.beam$', '_build', 'node_modules', 'deps']
let NERDTreeAutoDeleteBuffer = 1 " Auto delete buffer when files/folders are deleted by NERDTree
let NERDTreeQuitOnOpen = 1 " Auto close NERDTree when open a file
let NERDTreeMinimalUI = 1
map <leader>\ :NERDTreeToggle<CR>

" Settings for Coc
" show hints/documentations
nnoremap <silent>? :call CocAction('doHover')<CR>

" Global clipboard
if empty($SSH_CONNECTION) && has('clipboard')
 set clipboard^=unnamed                " Use vim global clipboard register
 if has('unnamedplus') || has('nvim')  " Use system clipboard register
   set clipboard^=unnamedplus
 endif
endif

" Setup for ripgrep, fzf
" To show preview in fashion way, you need to install bat - a cat alternative
" programe
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --glob "!{node_modules,build,package/*}"'
let $FZF_DEFAULT_OPTS='
            \ --color=fg:#9CA3AF,bg:#1F2937,hl:#FBBF24
            \ --color=fg+:#ffffff,bg+:#6B7280,hl+:#f57900
            \ --color=info:#afaf87,prompt:#d7005f,pointer:#cc0000
            \ --color=marker:#DB2777,spinner:#af5fff,header:#729fcf'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --glob "!{node_modules,_build,packages,tags.temp,tags.lock,client}" --column --line-number --no-heading --smart-case --color=never --ignore-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', 'ctrl-/'),
  \   <bang>0)

"Restore cursor to file position in previous editing session
""http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"set viminfo='10,\"100,:20,%,n~/.viminfo
" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Settings for Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Settings for gutentags
set statusline+=%{gutentags#statusline()}

" Settings for auto-pairs
let g:AutoPairsMultilineClose = 0


lua << EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF
