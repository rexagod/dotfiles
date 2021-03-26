" Author: @rexagod

" Notes {{{

" Mappings for Go.
" {range}norm <normal mode keystrokes>
" }}}

" Plugins {{{

call plug#begin('~/.vim/plugged')

" coc.nvim {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}

" Git {{{

Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'stsewd/fzf-checkout.vim'
" }}}

" Go {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }}}

" Internals {{{

Plug 'aymericbeaumet/vim-symlink'
Plug 'vim-test/vim-test'
Plug 'Shougo/neomru.vim'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'drzel/vim-repo-edit'
Plug 'voldikss/vim-floaterm'
Plug 'editorconfig/editorconfig-vim'
" }}}

" Navigation {{{

Plug 'justinmk/vim-sneak'
Plug 'phaazon/hop.nvim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
" }}}

" Text Manipulations {{{

Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
" {lhs} {rhs}                   ~{{{
" ----- ----------------------  ~
" ai    <Plug>(textobj-indent-a) " includes blanks
" ii    <Plug>(textobj-indent-i)
" consecutive same level indents:
" aI    <Plug>(textobj-indent-same-a)
" iI    <Plug>(textobj-indent-same-i)
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
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
" }}}

" Visuals {{{

Plug 'markonm/traces.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-peekaboo'
" }}}

" Syntax {{{

Plug 'sainnhe/everforest'
Plug 'arcticicestudio/nord-vim'
Plug 'ghifarit53/tokyonight-vim'
" }}}

call plug#end()
" }}}

" Theme {{{

filetype plugin on
filetype indent on
set termguicolors
set background=dark
syntax enable

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1

let g:everforest_background = 'hard' " available: `'hard'`, `'medium'`, `'soft'`
let g:everforest_better_performance = 0
let g:everforest_current_word = 'bold' " available: 'grey background'`, `'bold'`, `'underline'`, `'italic'`
let g:everforest_diagnostic_line_highlight = 1
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_disable_italic_comment = 0
let g:everforest_enable_italic = 1

colorscheme everforest
" }}}

" Statusline (vim-airline) {{{

function! SanitizeModified() " {{{
  if &modified
    return ' [+]'
  endif
  return ''
endfunction
" }}}

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_left_sep="\ue0b8"
let g:airline_right_sep="\ue0ba"
let g:airline_inactive_alt_sep=1

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = ['conflicts']

let g:airline_section_a = airline#section#create(['mode', 'iminsert'])
let g:airline_section_b = airline#section#create(['%f', '%{SanitizeModified()}']) " Use <C-g> for a detailed view.
let g:airline_section_c = airline#section#create(['readonly'])
let g:airline_section_x = airline#section#create(['⎇  %{fugitive#head()}'])
let g:airline_section_y = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create(['%l', ':', '%v', '  ', '%p', '%%'])

let g:airline_theme = 'everforest'
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
set autoindent
set backupcopy=yes
set clipboard+=unnamedplus
set confirm
set expandtab
set fdm=marker
set foldopen=
set hidden
set laststatus=2
set matchtime=2
set mouse=a
set nobackup
set nohlsearch
set noignorecase
set noincsearch
set noshowmode
set nosmartcase
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
set sidescrolloff=10
set signcolumn=auto
set smartindent
set smarttab
set softtabstop=2
set ssop=blank,buffers,curdir,folds,globals,help,localoptions,options,tabpages,winsize
set swapfile
set tabstop=2
set tags+=.git/tags,../.git/tags
set termguicolors
set textwidth=0
set undodir=~/.vim-undo-dir
set undofile
set updatetime=100
set wildmenu
set wildmode=longest,full
" }}}

" Maps {{{

" Insert Mode Mappings {{{

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
ino    <S-Up>      <esc><C-e>a
ino    <S-Down>    <esc><C-y>a
" }}}

" Visual Mode Mappings {{{

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
vn    <S-Up>      <C-e>
vn    <S-Down>    <C-y>
" }}}

" Normal Mode Mappings {{{

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
nn    <S-Up>      <C-e>
nn    <S-Down>    <C-y>

nn    <silent><F2>    :messages<cr>
nn    <silent><F4>    :only<cr>

nn    <silent>QQ      :bd<cr>
nn    <F1>            <NOP>
" }}}

" Leader Mappings {{{

let mapleader="\<Space>"

nn <leader>a       ggVG
nn <silent><leader>zr :vsp $MYZSHRC<cr>
nn <silent><leader>vr :vsp ~/.vimrc<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>:echo &hls &is<cr>
nn <silent><nowait><leader>q :silent! call <SID>ToggleQuickFix()<cr>
nn <silent><nowait><leader>l :silent! call <SID>ToggleLocationList()<cr>
nn <silent><nowait><leader>s :silent! exec <SID>SourceScriptImplicit()<cr>
" }}}

" Localleader Mappings {{{

let maplocalleader='\'

nn <silent>\e :RangerWorkingDirectory<cr>
" }}}
" }}}

" Aliases {{{

com! QQ qall
" }}}

" Autocommands {{{

aug JSTS
  au!
  au Filetype *.js,*.ts setl suffixesadd=.js,.ts,.jsx,.tsx
aug END

aug FOO
  au!
  au Filetype help,qf nn <silent><buffer>q :q<cr>
  au BufReadPost * let b:lexima_disabled=0
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
aug END
" }}}

" Commands {{{

command! ClearMarksBuf delm!
command! W w
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

" bclose.vim {{{

let g:bclose_no_plugin_maps=1
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
nm <silent> gI <Plug>(coc-implementation)
nm <silent> gr <Plug>(coc-references)
nm <silent> gR <Plug>(coc-rename)
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
"}}}

" Insert Mode Mappings {{{

" Use tab for trigger completion with characters ahead and navigate.
ino <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use <c-space> to trigger completion.
ino <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
ino <silent><expr> <CR> pumvisible() ? "\<CR>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Hacky workaround to avoid pum when navigating
ino <Down> <Left><Right><Down>
ino <Up> <Left><Right><Up>
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

" editorconfig-vim {{{

let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']
" }}}

" fzf.vim {{{

" Vars {{{

let g:fzf_layout = { 'down': '100%' }
let g:preview_window_fmt = 'up:65%:rounded:nowrap:nofollow'
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
      \   'options': '--preview="bat --color always --theme Nord {}" --preview-window='.g:preview_window_fmt
      \ })<CR>
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" }}}

" Maps {{{

" Normal mode maps {{{

nn <silent>\\ :silent! RG<cr>
nn <silent>\b :silent! Buffers<cr>
nn <silent>\c :silent! BCommits<cr>
nn <silent>\C :silent! Commits<cr>
nn <silent>\d :silent! BD<cr>
nn <silent>\f :silent! Files<cr>
nn <silent>\F :silent! Filetypes<cr>
nn <silent>\g :silent! GFiles?<cr>
nn <silent>\G :silent! GFiles<cr>
nn <silent>\h :silent! History<cr>
nn <silent>\H :silent! Helptags<cr>
nn <silent>\k :silent! Commands<cr>
nn <silent>\l :silent! BLines<cr>
nn <silent>\L :silent! Lines<cr>
nn <silent>\m :silent! Maps<cr>
nn <silent>\M :silent! Marks<cr>
nn <silent>\t :silent! BTags<cr>
nn <silent>\T :silent! Tags<cr>
nn <silent>\w :silent! Windows<cr>
"}}}
" }}}
" }}}

" fzf-checkout.vim {{{

let g:fzf_checkout_git_options = '--sort=-committerdate'

nm <silent>\B :GBranches<cr>
" }}}

" hop.nvim {{{

nn <silent><M-w> :HopWord<cr>
nn <silent><M-1> :HopChar1<cr>
nn <silent><M-2> :HopChar2<cr>
nn <silent><M-l> :HopLine<cr>
" }}}

" ranger.vim {{{

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
" }}}

" undotree {{{

let g:undotree_SetFocusWhenToggle=1
let g:undotree_CursorLine=0
let g:undotree_HelpLine=0
let g:undotree_ShortIndicators=1
let g:undotree_WindowLayout=2
let g:undotree_SplitWidth=winwidth(0)/4
let g:undotree_TreeNodeShape='*'
let g:undotree_RelativeTimestamp=1

nn <silent><F3> :UndotreeToggle<CR>
" }}}

" vim-delete-hidden-buffers {{{

nn <silent><F5> :DeleteHiddenBuffers<cr>
" }}}

" vim-floaterm {{{

nn    <silent>   <F6>   :FloatermKill<CR>
tno   <silent>   <F6>   <C-\><C-n>:FloatermKill<CR>
nn    <silent>   <F7>    :FloatermNew<CR>
tno   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nn    <silent>   <F8>    :FloatermPrev<CR>
tno   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nn    <silent>   <F9>    :FloatermNext<CR>
tno   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nn    <silent>   <F10>   :FloatermToggle<CR>
tno   <silent>   <F10>   <C-\><C-n>:FloatermToggle<CR>
" }}}

" vim-go {{{

let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_diagnostics_level = 2
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
let g:go_list_type = 'quickfix'
let g:go_statusline_duration = 1000
let g:go_test_show_name = 0
let g:go_test_timeout= '10s'
let g:go_updatetime = 800
let g:go_play_open_browser = 0
let g:go_doc_popup_window = 1

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

aug GO
  au!
  au FileType go nm <silent>\t :GoDecls<cr>
  au FileType go nm <silent>\T :GoDeclsDir<cr>
  au FileType go nm <silent>' :call CocActionAsync('doHover')<cr>
  au FileType go nm <silent>\' :GoSameIdsToggle<cr>
  au Filetype godoc nn <silent>q :q<cr>
  au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
aug END

" }}}

" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}

" vim-test {{{

let test#strategy = "floaterm"
let g:test#preserve_screen = 0

nm <silent> tn :TestNearest<CR>
nm <silent> tf :TestFile<CR>
nm <silent> ts :TestSuite<CR>
nm <silent> tl :TestLast<CR>
nm <silent> tv :TestVisit<CR>
" }}}
" }}}
