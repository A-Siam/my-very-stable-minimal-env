" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


set number
set rnu

set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'udalov/kotlin-vim'
Plug 'nikvdp/ejs-syntax'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'preservim/nerdtree'
Plug 'dracula/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ryanoasis/vim-devicons'
"Plug 'prettier/vim-prettier', {
  "\ 'do': 'npm install',
  "\ 'branch': 'release/0.x'
  "\ }
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/loremipsum'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mlaursen/vim-react-snippets'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'puremourning/vimspector'
Plug 'preservim/nerdcommenter'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'mg979/vim-visual-multi'
Plug 'ajmwagar/vim-deus'
Plug 'Dimercel/todo-vim'
Plug 'grvcoelho/vim-javascript-snippets'
Plug 'morhetz/gruvbox'
Plug 'tell-k/vim-autopep8'
Plug 'mattn/emmet-vim'


call plug#end()

execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

nmap <Tab> :NERDTreeToggle<CR>

nnoremap <leader>n :NERDTree getcwd()<CR>

set encoding=UTF-8

" love the ayu theme but i really hate how unnoticeable the line number is so...
" NOTE: guifg because i use a gui terminal color YMMD
highlight LineNr guifg=#649649 


color dracula
set termguicolors

nmap <c-h> :vertical resize -5<CR>
nmap <c-l> :vertical resize +5<CR>
nmap <c-k> :resize -5<CR>
nmap <c-j> :resize +5<CR>

nmap <space>f :FZF<CR>
nmap <space>n :tabnew<CR>
nmap <c-t> :FloatermToggle<CR>

hi Normal guibg=NONE ctermbg=NONE

" COC
"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

let g:NERDTreeChDirMode = 2
let g:airline_theme='dracula'

let g:airline_symbols = {}

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" NERD TREE NERD STUFF
" close vim if noly nerd tree is the one working
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

set spell
set ignorecase
set smartcase

nmap <space><space>o :NERDTree

let g:NERDCustomDelimiters={
	\ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
\}

" after installing coc-docthis
nmap <space><space><space> :CocCommand docthis.documentThis<CR>

nnoremap <space><space>t :TODOToggle<CR>
nmap <space><space>s :wa<CR>

set cursorline
set colorcolumn=80

hi Normal guibg=NONE ctermbg=NONE

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nnoremap <F3> :vim
nnoremap <space>m :lnext<CR>
nnoremap <space>n :lprevious<CR>
nmap <C-P> :Prettier<CR>

hi Normal ctermbg=none
hi CursorLine guibg=#443350
 
" embedded terminal
set splitbelow
nnoremap <space>t :term<CR>

" fugitive 
nmap <space>gj :diffget //3<CR>
nmap <space>gf :diffget //2<CR>
nmap <space><space>g :G<CR>
set diffopt+=vertical
" always mouse support 
set term=xterm-256color
" organize mouse
set mouse=nvcr
set background=dark

nmap <space><C-m> <Plug>(coc-diagnostic-next)
nmap <space><C-n> <Plug>(coc-diagnostic-prev)

" emmet config
let g:user_emmet_mode='in'    
let g:user_emmet_install_global = 0
autocmd FileType html,css,jsx,ejs EmmetInstall

nmap <space><space>z :Goyo <bar> set number <bar> set rnu <CR>
nmap <space><space>n :noh<CR>
nmap <space><space>q :wa<CR>:q<CR>

" terminal bindings
tnoremap <Esc><Esc> <c-\><c-n>
