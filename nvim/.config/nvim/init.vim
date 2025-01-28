" Maintainer: @rexagod
" TODO: FZF /f but ignore /vendor.

" Plugins {{{

call plug#begin('~/.vim/plugged')
" Git {{{

Plug 'aacunningham/vim-fuzzy-stash'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
" }}}
" Internal {{{

Plug 'aymericbeaumet/vim-symlink'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'qpkorr/vim-bufkill'
" }}}
" Languages {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-jsonnet'
" }}}
" Navigation {{{

Plug 'Shougo/neomru.vim' | Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim' | Plug 'chengzeyi/fzf-preview.vim'
Plug 'phaazon/hop.nvim'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-unimpaired'
" }}}
" Text Manipulations {{{

Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user' | Plug 'coderifous/textobj-word-column.vim'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
" }}}
" Visuals {{{

Plug 'f-person/auto-dark-mode.nvim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-peekaboo'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'markonm/traces.vim'
Plug 'bettervim/yugen.nvim'
Plug 'jonathanfilip/vim-lucius'
Plug 'folke/zen-mode.nvim'
" }}}
call plug#end()
" }}}
" Theme {{{

filetype plugin indent on
set background=dark
set termguicolors
syntax on

color default "yugen
highlight NormalFloat guibg=#663300 guifg=#FFDAB9 gui=Italic
highlight ColorColumn guibg=#333333
:highlight Comment guifg=#FFDA89
highlight Operator guifg=#E8AF7D
" }}}
" Options {{{

set autowrite
set clipboard+=unnamedplus
set colorcolumn=72,80,120
set completeopt=menu,menuone,noselect
set confirm
set expandtab
set foldmethod=marker
set foldopen=
set is hls
set linebreak
set mouse+=a
set nohidden
set noshowmode
set noswapfile
set nowritebackup
set number
set pumheight=5
set relativenumber
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set scrolloff=1
set shiftwidth=2
set shortmess+=c
set showbreak=+++\ 
set showmatch
set sidescrolloff=10
set smartindent
set softtabstop=2
set tabstop=2
set tags=
set textwidth=80
set undodir=~/.vim-undo-dir
set undofile
set wildmode=longest,full
set wrap
set wrapmargin=80
" }}}
" Maps {{{

" Insert Mode Mappings {{{

imap <End>      <esc>5<Right>i
imap <Home>     <esc>5<Left>i
imap <PageUp>   <esc>5<Up>i
imap <PageDown> <esc>5<Down>i
" }}}
" Visual Mode Mappings {{{

vn  :sort<cr> " implicitly inserts the visual marker range

vm <Home>     5h
vm <PageDown> 5j
vm <PageUp>   5k
vm <End>      5l
" }}}
" Normal Mode Mappings {{{

nn <Tab>   :bnext<cr>
nn <S-Tab> :bprev<cr>

" Don't close the window if no buffers left.
nn <silent>Qq   :BD<cr>
nn <silent>QQ   :bd<cr>
nn <silent><F2> :messages<cr>
nn <silent><F4> :only<cr>

nm j          gj
nm k          gk
nm <Home>     5h
nm <PageDown> 5j
nm <PageUp>   5k
nm <End>      5l
" }}}
" Leader Mappings {{{

let                                            mapleader="\<Space>"

nn <silent><leader>vr        :vsp              $VIMRC<cr>
nn <silent><leader>zr        :vsp              $ZSHRC<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>
" }}}
" }}}
" Autocommands {{{

aug FOO
  au!
  au Filetype sh,bash,zsh setl keywordprg=:Man
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  au ColorScheme * highlight Comment cterm=italic gui=italic
  au Filetype help,qf nn <silent><buffer>q :q<cr>
aug END
" }}}
" Commands {{{

command! GoRunZ w | belowright 25split | term bash -c "go run ."
command! CM delm!
command! MC mapclear | mapclear <buffer> | mapclear! | mapclear! <buffer>
command! QQ qall
command! S w | source %
command! SS mks! ~/.session.vim
command! FI PlugClean | PlugInstall | PlugUpdate | PlugUpgrade
command! HI PlugClean | PlugInstall
command! W w | e
" }}}
" Plugin Configurations {{{

" built-ins {{{

packadd! cfilter
packadd! matchit
" }}}
" bclose.vim {{{

let g:bclose_no_plugin_maps=1
" }}}
" clever-f.vim {{{

let g:clever_f_across_no_line=0
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

nn <silent><Space>w :HopWord<cr>
nn <silent><Space>1 :HopChar1<cr>
nn <silent><Space>2 :HopChar2<cr>
" }}}
" lightline.vim {{{

let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'gitbranch', 'stats' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \   'stats': 'SignifyStats'
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! SignifyStats()
  return sy#repo#get_stats_decorated()
endfunction
" }}}
" ranger.vim {{{

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=false"'

nn <silent>\e :RangerCurrentFile<cr>
" }}}
" vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
" vim-fugitive {{{

nm <silent><leader>b :Git blame<cr>
" }}}
" vim-fuzzy-stash {{{

command! GSL GStashList

let g:fuzzy_stash_actions =
  \ {
  \ 'ctrl-d': 'drop',
  \ 'ctrl-p': 'pop',
  \ 'ctrl-a': 'apply',
  \ }
" }}}
" vim-go {{{

" Variables {{{

let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_decls_mode = 'fzf'
let g:go_diagnostics_level = 2
let g:go_doc_balloon = 1
let g:go_doc_popup_window = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 0
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 0
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_list_type = 'quickfix'
let g:go_statusline_duration = 5000
let g:go_test_show_name = 1
let g:go_test_timeout= '10s'
let g:go_updatetime = 100
" }}}
" Mappings {{{

aug GO
  " gd - Goto definition.
  " C-t - Go back.
  " if, af - Function selectors.
  " [[, ]] - Move between functions.

  au FileType go nm <silent>'C :GoCoverageToggle<cr>
  au FileType go nm <silent>'D :GoDeclsDir<cr>
  au FileType go nm <silent>'R :GoRename<cr>
  au FileType go nm <silent>'a :GoAlternate<cr>
  au FileType go nm <silent>'b :GoBuild<cr>
  au FileType go nm <silent>'c :GoCallers<cr>
  au FileType go nm <silent>'d :GoDecls<cr>
  au FileType go nm <silent>'e :GoErrCheck<cr>
  au FileType go nm <silent>'h :GoSameIdsToggle<cr>
  au FileType go nm <silent>'p :GoImplements<cr>
  au FileType go nm <silent>'r :GoReferrers<cr>
  au FileType go nm <silent>'z :GoRunZ<cr>


aug END
" }}}
" }}}
" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}
" " indent-blankline.nvim {{{

" lua <<EOF
" vim.opt.list = true
" vim.opt.listchars:append "space:⋅"
" vim.opt.listchars:append "eol:↴"
" EOF
" " }}}
" }}}
" Internals {{{

" GoRun compatibility
let g:go_term_enabled = 1
let g:go_term_close_on_exit = 1
let g:go_term_mode = "split"
" }}}
