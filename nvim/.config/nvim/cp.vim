" Maintainer: @rexagod
" PY vimrc for competitive coding.

" Plugins {{{

call plug#begin('~/.vim/plugged')
" Internal {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'aymericbeaumet/vim-symlink'
Plug 'tpope/vim-eunuch' " Unix helpers.
Plug 'tpope/vim-sleuth' " Heuristics.
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
Plug 'wellle/targets.vim'
" }}}
" Navigation {{{

Plug 'Shougo/neomru.vim' | Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim' | Plug 'chengzeyi/fzf-preview.vim'
Plug 'phaazon/hop.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-unimpaired'
" }}}
" Text Manipulations {{{

Plug 'machakann/vim-swap'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" }}}
" Visuals {{{

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'itchyny/lightline.vim'
Plug 'challenger-deep-theme/vim'
" }}}
call plug#end()
" }}}
" Theme {{{

syntax on
filetype plugin indent on

colorscheme challenger_deep
" }}}
" Options {{{

set autowrite
set clipboard+=unnamedplus " bugs 'x' up
set colorcolumn=120
set completeopt=menu,menuone,noselect
set confirm
set foldmethod=marker
set foldopen=
set is hls
set mouse+=a
set noexpandtab
set noshowmode
set noswapfile
set nowritebackup
set number
set pumheight=5
set relativenumber
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set scrolloff=1
set shortmess+=c
set showmatch
set sidescrolloff=10
set smartindent
set tags=
set textwidth=120
set undodir=~/.vim-undo-dir
set undofile
set wildmode=longest,full
set wrap
" }}}
" Maps {{{

" Insert Mode Mappings {{{

ino <C-j> <esc>5<Down>a
ino <C-k> <esc>5<Up>a
ino <C-l> <esc>5<Right>a
ino <C-h> <esc>5<Left>a

imap <C-Left> <C-h>
imap <C-Right> <C-l>
imap <C-Down> <C-j>
imap <C-Up> <C-k>
" }}}
" Visual Mode Mappings {{{

vn <C-s> :sort<cr> " implicitly inserts the visual marker range

vm <C-Down> <C-j>
vm <C-Left> <C-h>
vm <C-Right> <C-l>
vm <C-Up> <C-k>
vm <C-h> 5h
vm <C-j> 5j
vm <C-k> 5k
vm <C-l> 5l
vm <S-Down> <C-y>
vm <S-Up> <C-e>
" }}}
" Normal Mode Mappings {{{

nn <F1> :w<cr>:!python3 %<cr>

nn <C-h> b
nn <C-l> w
nn <C-j> 5j
nn <C-k> 5k
nn <Tab> :bnext<cr>
nn <S-Tab> :bprev<cr>
nn <silent><F2> :messages<cr>
nn <silent><F4> :only<cr>
nn <silent>QQ :bd<cr>
nn j gj
nn k gk

nm <S-Down> <C-y>
nm <S-Up> <C-e>
nm <C-Left> <C-h>
nm <C-Right> <C-l>
nm <C-Down> <C-j>
nm <C-Up> <C-k>
nm <Up> k
nm <Down> j
nm <Left> h
nm <Right> l
" }}}
" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>vr        :vsp $VIMRC<cr>
nn <silent><leader>zr        :vsp $ZSHRC<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>:echo &hls &is<cr>
" }}}
" }}}
" Autocommands {{{

aug FOO
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  au ColorScheme * highlight Comment cterm=italic gui=italic
  au Filetype help,qf nn <silent><buffer>q :q<cr>
aug END
" }}}
" Macros {{{

let @y='"+y' " Fix copy without breaking x.
" }}}
" Functions {{{

function! s:ToggleX() " {{{
  if &clipboard ==# "unnamedplus"
    set clipboard-=unnamedplus
  else
    set clipboard+=unnamedplus
  endif
endfunction

nn <silent><nowait><leader>c :silent! call <SID>ToggleX()<cr>
" }}}
" }}}
" Commands {{{

command! CM delm!
command! CPVIMRC vsp $CPVIMRC
command! MC mapclear | mapclear <buffer> | mapclear! | mapclear! <buffer>
command! OC set all&
command! QQ qall
command! S w | source %
command! SS mks! ~/.session.vim
command! U2 PlugClean | PlugInstall
command! U4 PlugClean | PlugInstall | PlugUpdate | PlugUpgrade
command! W w | e
" }}}
" Plugin Configurations {{{

" standard plugins {{{

packadd! cfilter
packadd! matchit
" }}}
" clever-f.vim {{{

let g:clever_f_across_no_line=1
let g:clever_f_smart_case=1
let g:clever_f_chars_match_any_signs="."
let g:clever_f_mark_cursor=1
" }}}
" fzf.vim {{{

" Vars {{{

let g:fzf_layout = { 'up': '100%' }
let g:fzf_preview_window = [ 'up:60%:rounded:nowrap:nofollow' ]
" }}}
" Commands {{{

command! FZFShow call fzf#run(fzf#wrap({
      \ 'source': 'git show --format=oneline --name-only --relative | tail --lines=+2', 
      \ 'sink': 'e',
      \ 'options': '--multi --reverse --preview "git diff HEAD^ HEAD {} | delta --color-only" --preview-window "up,80%,rounded"',
      \ }))
" }}}
" Maps {{{

nn <silent>\/ :silent! FZFGGrep<cr>
nn <silent>\C :silent! Commits<cr>
nn <silent>\F :silent! Filetypes<cr>
nn <silent>\G :silent! GFiles<cr>
nn <silent>\H :silent! Helptags<cr>
nn <silent>\L :silent! FZFLocList<cr>
nn <silent>\M :silent! FZFMarks<cr>
nn <silent>\T :silent! FZFTags<cr>
nn <silent>\\ :silent! FZFRg<cr>
nn <silent>\b :silent! Buffers<cr>
nn <silent>\c :silent! BCommits<cr>
nn <silent>\d :silent! BD<cr>
nn <silent>\f :silent! FZFFiles<cr>
nn <silent>\g :silent! GFiles?<cr>
nn <silent>\h :silent! FZFHistory<cr>
nn <silent>\k :silent! Commands<cr>
nn <silent>\l :silent! FZFBLines<cr>
nn <silent>\m :silent! Maps<cr>
nn <silent>\q :silent! FZFQuickFix<cr>
nn <silent>\s :silent! FZFShow<cr>
nn <silent>\t :silent! FZFBTags<cr>
nn <silent>\w :silent! FZFWindows<cr>
" }}}
" }}}
" hop.nvim {{{

augroup HOP
  autocmd!
  autocmd VimEnter * lua require'hop'.setup()
augroup END

nn <silent><M-w> :HopWord<cr>
nn <silent><M-1> :HopChar1<cr>
nn <silent><M-2> :HopChar2<cr>
" }}}
" lightline.vim {{{
" landscape
" powerlineish
" rosepine
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
" }}}
" targets.vim {{{
" https://github.com/wellle/targets.vim/blob/master/cheatsheet.md
" }}}
" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}
" Lua Configurations {{{
" indent-blankline.nvim {{{

lua <<EOF
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  show_end_of_line = true,
  space_char_blankline = " ",
}
EOF
" }}}
" }}}
" }}}
