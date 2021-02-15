" Author: @rexagod

" TODO {{{

" Install sneak
" Setup debugger.
" Use rg regexp for all fzf commands.
" }}}

" Notes {{{

" Unmap replaced mappings when using newer ones in place of them.
" }}}

"  Plugins {{{

call plug#begin('~/.vim/plugged')

" coc.nvim {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}

" Git {{{

Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive' |
      \ Plug 'tpope/vim-rhubarb' |
" }}}

" Go {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }}}

" Navigation {{{

Plug 'phaazon/hop.nvim' " Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-unimpaired'
Plug 'yangmillstheory/vim-snipe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim'
Plug 'Shougo/neomru.vim'
Plug 'arithran/vim-delete-hidden-buffers'
" }}}

" Text Manipulations {{{

Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
	" {lhs}	{rhs}			~{{{
	" -----	----------------------	~
	" ai	<Plug>(textobj-indent-a) " includes blanks
	" ii	<Plug>(textobj-indent-i)
  " consecutive same level indents:
	" aI	<Plug>(textobj-indent-same-a)
	" iI	<Plug>(textobj-indent-same-i)
"}}}
Plug 'coderifous/textobj-word-column.vim'
"{{{
"                                                    *ac* *cac* *dac* *vac* *yac*
" ac               "a column", a column based on "a word" |aw|.

"                                                    *ic* *cic* *dic* *vic* *yic*
" ic               "inner column", a column based on the "inner word" |iw|.

"                                                    *aC* *caC* *daC* *vaC* *yaC*
" aC               "a COLUMN", a column based on "a WORD" |aW|.

"                                                    *iC* *ciC* *diC* *viC* *yiC*
" iC               "inner COLUMN", a column based on "inner WORD" |iW|.
"}}}
Plug 'cohama/lexima.vim'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
" }}}

" Visuals {{{

Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'drzel/vim-repo-edit'
Plug 'itchyny/lightline.vim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/vim-peekaboo'
Plug 'editorconfig/editorconfig-vim'
" }}}

" Syntax {{{

Plug 'ghifarit53/tokyonight-vim'
" }}}

" nvim-treesitter {{{

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" }}}

call plug#end()
" }}}

" Theme {{{

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

filetype plugin on
filetype indent on
syntax enable

set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
" }}}

" lightline.vim {{{

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! RowColNumber()
  return line('.').':'.col('.')
endfunction

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'coc'] ],
      \   'right': [ [ 'rowcolnumber', 'percent' ],
      \              [ 'gitbranch', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'coc': 'coc#status',
      \   'filename': 'LightlineFilename',
      \   'rowcolnumber': 'RowColNumber',
      \ },
      \ 'mode_map': {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'VL',
      \ "\<C-v>": 'VB',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'SL',
      \ "\<C-s>": 'SB',
      \ 't': 'T',
      \ },
      \ }
" }}}

" Variables {{{

let loaded_netrwPlugin = 1
" }}}

" Functions {{{

function! s:SourceScriptImplicit() " {{{
  if !&readonly && &filetype !=# ''
    w
  endif
  if &filetype ==# ''
    return ''
  endif
  let l:bin=system("which " . &filetype)[:-2]
  if l:bin==# ''
    return ''
  endif
  let l:sourcecommand=
        \ {
        \ "vim":         "source %",
        \ }
  let l:ispresent=has_key(l:sourcecommand, split(l:bin, "/")[-1])
  return l:ispresent ? l:sourcecommand[split(l:bin, "/")[-1]] : ''
endfunction
" }}}

function! s:ToggleQuickFix() " {{{
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
" }}}

function! s:ToggleLocationList() " {{{
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    lopen
  else
    lclose
  endif
endfunction
" }}}
" }}}

" Options {{{

" set grepprg=rg\ --vimgrep
set autoread
set autowrite
set background=dark
set backupcopy=yes
set clipboard+=unnamedplus
set confirm
set expandtab
set fdm=marker
set foldopen=
set hidden
set noignorecase
set laststatus=2
set matchtime=2
set mouse=a
set nobackup
set nohlsearch
set noincsearch
set noshowmode
set swapfile
set nowrap
set nowritebackup
set number
set omnifunc=syntaxcomplete#Complete
set path=.,,
set re=0
set relativenumber
set ruler
set scroll=5
set scrolloff=0
set shiftwidth=2
set shortmess+=c
set showcmd
set showmatch
set sidescrolloff=0
set signcolumn=auto
set nosmartcase
set smartindent
set smarttab
set ssop=blank,buffers,curdir,folds,globals,help,localoptions,options,tabpages,winsize
set tabstop=2
set tags+=.git/tags,../.git/tags
set termguicolors
set textwidth=0
set undodir=~/.vim-undo-dir
set undofile
set updatetime=300
set wildmenu
set wildmode=longest,full
" }}}

" Maps {{{

" Insert Mode Mappings {{{

ino   <PageDown>  <Right>
ino   <PageUp>    <Left>

ino   <C-j>       <esc>5ja
ino   <C-k>       <esc>5ka
ino   <C-h>       <esc>5ha
ino   <C-l>       <esc>5la

imap  <C-Right>   <esc>5la
imap  <C-Left>    <esc>5ha
imap  <C-Up>      <esc>5ka
imap  <C-Down>    <esc>5ja

ino    <S-Right>   <Nop>
ino    <S-Left>    <Nop>
ino    <S-Up>      <Nop>
ino    <S-Down>    <Nop>
" }}}

" Visual Mode Mappings {{{

vn    <PageDown>  l
vn    <PageUp>    h

vn    <C-j>       5j
vn    <C-k>       5k
vn    <C-h>       5h
vn    <C-l>       5l

vm    <C-Right>   <C-l>
vm    <C-Left>    <C-h>
vm    <C-Up>      <C-k>
vm    <C-Down>    <C-j>

vn    <S-Right>   <Nop>
vn    <S-Left>    <Nop>
vn    <S-Up>      <Nop>
vn    <S-Down>    <Nop>
" }}}

" Normal Mode Mappings {{{

nn    <PageDown>  l
nn    <PageUp>    h

nn    <C-j>       5j
nn    <C-k>       5k
nn    <C-h>       5h
nn    <C-l>       5l

nm    <C-Right>   <C-l>
nm    <C-Left>    <C-h>
nm    <C-Up>      <C-k>
nm    <C-Down>    <C-j>

nn    <S-Right>   <Nop>
nn    <S-Left>    <Nop>
nn    <S-Up>      <Nop>
nn    <S-Down>    <Nop>

nn    <silent><F1>    :exec "bo 10new +normal!\\ G\ /etc/x/vrc.txt"<cr>
nn    <silent><F2>    :messages<cr>
nn    <silent><F4>    :only<cr>

nn    <silent>QQ      :bd<cr>
nn    <C-b>           :ls<cr>:b
nn    n               N
nn    N               n
nn    #               *
nn    *               #
" nn    <silent>T       :exec "!trans".expand("\<cword>")<cr>
" }}}

" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>zr :vsp $MYZSHRC<cr>
nn <silent><leader>vr :vsp ~/.vimrc<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>:echo &hls &is<cr>
nn <silent><nowait><leader>q :call <SID>ToggleQuickFix()<cr>
nn <silent><nowait><leader>l :call <SID>ToggleLocationList()<cr>
nn <silent><nowait><leader>s :exec <SID>SourceScriptImplicit()<cr>
" }}}

" Localleader Mappings {{{

let maplocalleader='\'

nm \<tab> a<C-Space>

" }}}
" }}}

" Aliases {{{

com! QQ qall
" }}}

" Autocommands {{{

aug JSTS
  au!
  au Filetype setl suffixesadd=.js,.ts,.jsx,.tsx
  " Find a better alternative for this as it makes tsc go all fidgety
  " au FileType typescriptreact setl filetype=typescript
  " au FileType javascriptreact setl filetype=javascript
aug END

aug FOO
  au!
  au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
  au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
  au Filetype help,qf nn <silent><buffer>q :q<cr>
  au BufReadPost * let b:lexima_disabled=0
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  " au Filetype sh setl keywordprg=help
  " au BufReadPost .vimrc source %
  " au BufWinEnter,BufWinLeave * ++nested so $MYVIMRC 
aug END
" }}}

" Commands {{{

command! ClearMarksBuf delm!
command! W retab | normal mxgg=G`xdmx | w
" }}}

" Plugin Configurations {{{

" standard plugins {{{

packadd! cfilter
packadd! matchit
nn <silent><leader><leader>P :
      \ PlugClean<bar>
      \ PlugInstall<bar>
      \ PlugUpdate<bar>
      \ PlugUpgrade<bar>
      \ <cr>
nn <silent><leader><leader>p :
      \ PlugClean<bar>
      \ PlugInstall<bar>
      \ <cr>
" }}}

" coc.nvim {{{

" Functions {{{
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"}}}

" Commands {{{
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
"}}}

" Normal Mode Mappings {{{

" *g* Maps {{{
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nm <silent> [g <Plug>(coc-diagnostic-prev)
nm <silent> ]g <Plug>(coc-diagnostic-next)
nm <silent> gd <Plug>(coc-definition)
nm <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation) " overrides gi jumps
nm <silent> gr <Plug>(coc-references)
"}}}

" Mappings for CoCList {{{
" Show all diagnostics.
nn <silent><nowait> <M-a> :<C-u>CocList diagnostics<cr>
" Manage extensions.
nn <silent><nowait> <M-e> :<C-u>CocList extensions<cr>
" Show commands.
nn <silent><nowait> <M-c> :<C-u>CocList commands<cr>
" Find symbol of current document.
nn <silent><nowait> <M-o> :<C-u>CocList outline<cr>
" Search workspace symbols.
nn <silent><nowait> <M-s> :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nn <silent><nowait> <M-j> :<C-u>CocNext<CR>
" Do default action for previous item.
nn <silent><nowait> <M-k> :<C-u>CocPrev<CR>
" Resume latest coc list.
nn <silent><nowait> <M-p> :<C-u>CocListResume<CR>
"}}}

" Applying codeAction to the selected region. {{{
" Example: `<leader>aap` for current paragraph
xm \a  <Plug>(coc-codeaction-selected)
nm \a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nm \ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nm \qf  <Plug>(coc-fix-current)
"}}}

" Formatting selected code. {{{
nm <leader>f  <Plug>(coc-format-selected)
xm <leader>f  <Plug>(coc-format-selected)
"}}}

" Function and Class Objects {{{
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xm if <Plug>(coc-funcobj-i)
om if <Plug>(coc-funcobj-i)
xm af <Plug>(coc-funcobj-a)
om af <Plug>(coc-funcobj-a)
xm ic <Plug>(coc-classobj-i)
om ic <Plug>(coc-classobj-i)
xm ac <Plug>(coc-classobj-a)
om ac <Plug>(coc-classobj-a)
" }}}

" Show documentation in preview window. {{{
nn <silent> K :call <SID>show_documentation()<CR>
"}}}

" Use CTRL-S for selections ranges. {{{
" Requires 'textDocument/selectionRange' support of language server.
nm <silent> <C-s> <Plug>(coc-range-select)
xm <silent> <C-s> <Plug>(coc-range-select)
"}}}

"" Symbol renaming. {{{
"nm <leader>rn <Plug>(coc-rename)
""}}}
"}}}

" Insert Mode Mappings {{{

" Use tab for trigger completion with characters ahead and navigate.
ino <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use <c-space> to trigger completion.
ino <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
ino <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}

" Autocommands {{{
aug CoC
  au!
  " Highlight the symbol and its references when holding the cursor.
  au CursorHold * silent call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
aug END
"}}}

" Remap <C-f> and <C-b> for scroll float windows/popups. {{{
nn <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nn <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
vn <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vn <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
ino <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
ino <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"}}}
" }}}

" coc-explorer {{{

" nn <C-n> :CocCommand explorer<cr>

nmap <silent><C-n> :CocCommand explorer --preset floating<CR>
" nmap <silent>\B :CocCommand explorer --preset buffer<CR>

let g:coc_explorer_global_presets = {
      \   '.vim': {
      \     'root-uri': '~/.vim',
      \   },
      \   'cocConfig': {
      \      'root-uri': '~/.config/coc',
      \   },
      \   'tab': {
      \     'position': 'tab',
      \     'quit-on-open': v:true,
      \   },
      \   'floating': {
      \     'position': 'floating',
      \     'open-action-strategy': 'sourceWindow',
      \   },
      \   'floatingTop': {
      \     'position': 'floating',
      \     'floating-position': 'center-top',
      \     'open-action-strategy': 'sourceWindow',
      \   },
      \   'floatingLeftside': {
      \     'position': 'floating',
      \     'floating-position': 'left-center',
      \     'floating-width': 50,
      \     'open-action-strategy': 'sourceWindow',
      \   },
      \   'floatingRightside': {
      \     'position': 'floating',
      \     'floating-position': 'right-center',
      \     'floating-width': 50,
      \     'open-action-strategy': 'sourceWindow',
      \   },
      \   'simplify': {
      \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
      \   },
      \   'buffer': {
      \     'sources': [{'name': 'buffer', 'expand': v:true}]
      \   },
      \ }

" Use preset argument to open it
" nmap <space>ef :CocCommand explorer --preset floating<CR>

" List all presets
" nmap <space>el :CocList explPresets
" }}}

" nvim-treesitter {{{

  " incremental_selection = {
  "   enable = true,
  "   keymaps = {
  "     init_selection = "",
  "     node_incremental = "g(",
  "     scope_incremental = "",
  "     node_decremental = "",
  "   },
  " },

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  context = { enable = true },
  highlight = { enable = true, },
  indent = { enable = true, },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {smart_rename = "grr"},
    },
  },
}
EOF
" }}}

" fzf.vim {{{

" Vars {{{

let g:preview_window_fmt = 'up:60%:rounded:nowrap:nofollow'
let g:fzf_preview_window = [ g:preview_window_fmt ]
" }}}

" Functions {{{

" Delete buffers {{{

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
      \ 'source': s:list_buffers(),
      \ 'sink*': { lines -> s:delete_buffers(lines) },
      \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
      \ }))
" }}}

function! RipgrepFzf(query, fullscreen) " {{{
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--preview-window='.g:preview_window_fmt, '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
" }}}
" }}}

" Commands {{{

command! History call fzf#run({
      \   'source': 'sed "1d" $HOME/.cache/neomru/file',
      \   'sink': 'e ',
      \   'down': '10'
      \ })<CR>
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" }}}

" Maps {{{

" Normal mode maps {{{

nn \\ :RG<cr>
nn \b :Buffers<cr>
nn \c :BCommits<cr>
nn \C :Commits<cr>
nn \d :BD<cr>
nn \f :Files<cr>
nn \F :Filetypes<cr>
nn \g :GFiles?<cr>
nn \G :GFiles<cr>
nn \h :History<cr>
nn \H :Helptags<cr>
nn \k :Commands<cr>
nn \l :BLines<cr>
nn \L :Lines<cr>
nn \m :Maps<cr>
nn \M :Marks<cr>
nn \t :BTags<cr>
nn \T :Tags<cr>
nn \w :Windows<cr>
"}}}

"" Insert mode completion {{{

"inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1  }})
"inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files', {'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1  }})
"inoremap <expr> <c-x><c-l> fzf#vim#complete#line({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1  }})
""}}}

"" Maps for n,x,o modes {{{

"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)
""}}}
" }}}
" }}}

" fzf-checkout.vim {{{

let g:fzf_checkout_git_options = '--sort=-committerdate'

nm <silent>\B :GBranches<cr>
" }}}

" vim-floaterm {{{

nn    <silent>   <F7>    :FloatermNew<CR>
tno   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nn    <silent>   <F8>    :FloatermPrev<CR>
tno   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nn    <silent>   <F9>    :FloatermNext<CR>
tno   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nn    <silent>   <F10>   :FloatermToggle<CR>
tno   <silent>   <F10>   <C-\><C-n>:FloatermToggle<CR>
nn    <silent>   <F12>   :FloatermKill<CR>
tno   <silent>   <F12>   <C-\><C-n>:FloatermKill<CR>
" }}}

" vim-delete-hidden-buffers {{{

nn <silent><F5> :DeleteHiddenBuffers<cr>
" }}}

" editorconfig-vim {{{

let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']
" }}}

" vim-snipe {{{

let g:snipe_jump_tokens              = 'aoeuidhtns'
let g:snipe_highlight_gui_color      = '#dfffaf'
let g:snipe_highlight_cterm256_color = 'blue'
let g:snipe_highlight_cterm_color    = 'red'

" Find
nm <leader><leader>f <Plug>(snipe-f)
nm <leader><leader>F <Plug>(snipe-F)
nm <leader><leader>t <Plug>(snipe-t)
nm <leader><leader>T <Plug>(snipe-T)
" Goto (word/WORD)
nm <leader><leader>w <Plug>(snipe-w)
nm <leader><leader>W <Plug>(snipe-W)
nm <leader><leader>e <Plug>(snipe-ge)
nm <leader><leader>E <Plug>(snipe-gE)
nm <leader><leader>b <Plug>(snipe-b)
nm <leader><leader>B <Plug>(snipe-B)
" Swap
nm <leader><leader>] <Plug>(snipe-f-xp)
nm <leader><leader>[ <Plug>(snipe-F-xp)
" Cut
nm <leader><leader>x <Plug>(snipe-f-x)
nm <leader><leader>X <Plug>(snipe-F-x)
" Replace
nm <leader><leader>r <Plug>(snipe-f-r)
nm <leader><leader>R <Plug>(snipe-F-r)
" Append
nm <leader><leader>a <Plug>(snipe-f-a)
nm <leader><leader>A <Plug>(snipe-F-a)
" }}}

" hop.nvim {{{

nn <silent><M-w> :HopWord<cr>
nn <silent><M-1> :HopChar1<cr>
nn <silent><M-2> :HopChar2<cr>
nn <silent><M-l> :HopLine<cr>
" }}}

" vim-go {{{

let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_imports_autosave = 1
let g:go_info_mode = 'gopls'
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_test_show_name = 0
let g:go_test_timeout= '10s'
let g:go_updatetime = 800
let g:go_play_open_browser = 0

" Use ctrl-t for :GoDefPop<cr> (see :GoDefStack){{{
" Also see:
" :GoDescribe
" :GoImplements
" :GoWhicherr -> all possible values err can return
" :GoPeerChannels
" :GoCallers
" :GoCallees
" :GoCallstack
" :GoGuruScope
" :GoBuildTags mycustomtag " // +build linux darwin OR +build mycustomtag (highlighted when detected)
" This will pass this tag to guru and from now on it'll work as expected. And just like :GoGuruScope, you can clear it with:
" :GoBuildTags ""
" And finally if you wish you can make it permanent with the following setting:
" let g:go_build_tags = "mycustomtag"
" :GoRename
" :GoFreevars
" :GoImpl -> Util fns
"}}}

augroup lightline_hl
  au!
  au BufWinEnter,BufWinLeave * call lightline#disable() | call lightline#enable()
augroup END

aug GO
  au!
  au FileType go nm <silent>\t :GoDecls<cr>
  au FileType go nm <silent>\T :GoDeclsDir<cr>
  au FileType go nm <silent>' :call CocActionAsync('doHover')<cr>
  au FileType go nm <silent>\' :GoSameIdsToggle<cr>
  au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
  au Filetype godoc nn <silent>q :q<cr>
aug END

" }}}

" undotree {{{

let g:undotree_SetFocusWhenToggle=1
let g:undotree_CursorLine=0
let g:undotree_HelpLine=0
let g:undotree_ShortIndicators=1
let g:undotree_WindowLayout=2
let g:undotree_SplitWidth=winwidth(0)/6
let g:undotree_TreeNodeShape='*'
let g:undotree_RelativeTimestamp=1

nn <silent><F3> :UndotreeToggle<CR>
" }}}

" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}

" lexima.vim {{{

let g:lexima_enable_endwise_rules=0

" nn <F5> :let b:lexima_disabled=
" }}}
" }}}
