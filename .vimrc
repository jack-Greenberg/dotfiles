""""""""""""
" SETTINGS "
""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on
set hidden
set cmdheight=2
set number
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set hlsearch
set incsearch
set showcmd
set so=5
set smarttab
set ai
set si
set wildmenu
set guicursor=
set cursorline
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set splitright
set linebreak
set t_Co=256
set wildignore+=.git/*,node_modules/,venv/,__pycache__/

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab " Yaml should be 2 spaces indent
autocmd FileType toml setlocal shiftwidth=2 softtabstop=2 expandtab " Toml should be 2 spaces indent autocmd FileType sh setlocal shiftwidth=2 softtabstop=2 expandtab " Bash files should be 2 spaces indent

" if has("autocmd")
"   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" endif


"""""""""""
" PLUGINS "
"""""""""""
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'Rigellute/rigel'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'lambdalisue/gina.vim'
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'plasticboy/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//' } }
let g:NERDCommentEmptyLines = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:plug_window = 'noautocmd vertical topleft new'

" let b:ale_linters = ['flake8']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {'rust': ['analyzer'], 'python': ['flake8']}

let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 10000
let g:gitgutter_sign_added = '▏'
let g:gitgutter_sign_modified = '▏'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▏'
let g:gitgutter_sign_modified_removed = '▏'
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_override_sign_column_highlight = 0

let g:vim_markdown_folding_disabled = 1

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


""""""""""
" REMAPS "
""""""""""
map <C-n> :NERDTreeToggle<CR>
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nmap <C-g> :Goyo<CR>
vnoremap > >gv
vnoremap < <gv
cnoreabbrev ad ALEDisable
cnoreabbrev ae ALEEnable
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>

""""""""""""""
" APPEARANCE "
""""""""""""""
colorscheme rigel
set termguicolors
syntax enable
" set fillchars+=vert:\▏
set fillchars+=vert:\█
highlight Comment cterm=italic gui=italic
highlight MatchParen guibg=gray
highlight NonText guifg=bg
highlight Pmenu guibg=white guifg=black gui=bold


"""""""
" COC "
"""""""
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" 
" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
