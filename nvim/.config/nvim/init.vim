" Maintainer: @rexagod

" Todos {{{
" map caps to backspace
" Fix kp for :h
" fix the god-awful formatting
" }}}
" Plugins {{{

call plug#begin('~/.vim/plugged')
" Grammar {{{
" coc.nvim {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}
" }}}
" Go {{{

Plug 'ctrlpvim/ctrlp.vim' | Plug 'fatih/vim-go', { 'branch': 'master', 'do': ':GoUpdateBinaries' }
" }}}
" Git {{{

Plug 'aacunningham/vim-fuzzy-stash'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
" }}}
" Internal {{{

Plug 'aymericbeaumet/vim-symlink'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
" }}}
" Navigation {{{

Plug 'Shougo/neomru.vim' | Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim' | Plug 'chengzeyi/fzf-preview.vim'
" Plug 'kevinhwang91/nvim-bqf'
Plug 'phaazon/hop.nvim'
Plug 'preservim/vim-wheel'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-unimpaired'
" }}}
" Text Manipulations {{{

Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'kana/vim-textobj-user' | Plug 'coderifous/textobj-word-column.vim' | Plug 'adolenc/vim-textobj-toplevel'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" }}}
" Visuals {{{

Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
" }}}
call plug#end()
" }}}
" Variables {{{

let g:markdown_fenced_languages = ["vim", "lua", "javascript", "typescript", "go", "json", "xml"]
" }}}
" Options {{{

" set grepprg=rg\ --vimgrep
set autoindent
set autoread
set autowrite
set backupcopy=yes
set clipboard+=unnamedplus
set colorcolumn=80
set completeopt=menu,menuone,noselect
set conceallevel=0
set confirm
set cursorline
set encoding=UTF-8
set expandtab
set fdm=marker
set foldopen=
set hidden
set laststatus=2
set matchtime=2
set mouse=a
set nobackup
set noignorecase
set noshowmode
set nosmartcase
set noswapfile
set nowrap
set nowritebackup
set number
set numberwidth=4
set path=.,,
set pumheight=5
set re=0
set relativenumber
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set ruler
set scroll=10
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
set ssop=blank,buffers,curdir,folds,help,tabpages,winsize
set tabstop=2
set tags=
set textwidth=80
set undodir=~/.vim-undo-dir
set undofile
set updatetime=100
set wildmenu
set wildmode=longest,full
set pumblend=30
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

vm <C-j>     5j
vm <C-k>     5k
vm <C-l>     5l
vm <C-h>     5h
vm <S-Down> <C-y>
vm <S-Up>   <C-e>
vn <C-s>    :sort<cr> " implicitly inserts the visual marker range

vm <C-Left> <C-h>
vm <C-Right> <C-l>
vm <C-Down> <C-j>
vm <C-Up> <C-k>
" }}}
" Normal Mode Mappings {{{

nn <C-h>        b
nn <C-l>        w
nn <C-j>        5j
nn <C-k>        5k
nn <F1>         <NOP>
nn <S-j>        <C-y>
nn <S-k>        <C-e>
nn <Tab>        :bnext<cr>
nn <S-Tab>      :bprev<cr>
nn <silent><F2> :messages<cr>
nn <silent><F4> :only<cr>
nn <silent>QQ   :bd<cr>
nn j            gj
nn k            gk

nm <S-Down>     <C-y>
nm <S-Up>       <C-e>
nm <C-Left>     <C-h>
nm <C-Right>    <C-l>
nm <C-Down>     <C-j>
nm <C-Up>       <C-k>
nm <Up> k
nm <Down> j
nm <Left> h
nm <Right> l
" }}}
" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>vr        :vsp $VIMRC<cr>
nn <silent><leader>zr        :vsp $ZSHRC<cr>
nn <silent><leader>tr        :vsp $TMUXRC<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>:echo &hls &is<cr>
" }}}
" }}}
" Autocommands {{{

aug FOO
  au!
  " au BufWritePost * silent! !ctags -R &
  " au Filetype *.js,*.ts setl suffixesadd=.js,.ts,.jsx,.tsx
  au Filetype help,qf nn <silent><buffer>q :q<cr>
  " au Filetype help setl keywordprg=:Man
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  au ColorScheme * highlight Comment cterm=italic gui=italic
aug END
" }}}
" Commands {{{

command! CC cclose
command! CI PlugClean | PlugInstall
command! CM delm!
command! QQ qall
command! S w | source %
command! SS mks! ~/.session.vim
command! W w | e
command! YY PlugClean | PlugInstall | PlugUpdate | PlugUpgrade | CocUpdate
" }}}
" Plugin Configurations {{{

" standard plugins {{{

packadd! cfilter
packadd! matchit
" }}}
" bclose.vim {{{

let g:bclose_no_plugin_maps=1
" }}}
" coc.nvim {{{

" coc-snippets {{{

let g:coc_snippet_prev = '<C-a>'
let g:coc_snippet_next = '<C-s>'

xm <leader>x <Plug>(coc-convert-snippet)
" }}}
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
"}}}
" Normal Mode Mappings {{{

inoremap <silent><expr><c-space> coc#refresh()
" *g* Maps {{{
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nm <silent>[g <Plug>(coc-diagnostic-prev)
nm <silent>]g <Plug>(coc-diagnostic-next)
nm <silent>gd <Plug>(coc-definition)
nm <silent>gy <Plug>(coc-type-definition)
nm <silent>gI <Plug>(coc-implementation)
nm <silent>gr <Plug>(coc-references)
nm <silent>gR <Plug>(coc-rename)
" }}}
" Mappings for CoCList {{{
" Show all diagnostics.
nn <silent><nowait><M-a> :<C-u>CocList diagnostics<cr>
" Manage extensions.
nn <silent><nowait><M-e> :<C-u>CocList extensions<cr>
" Show commands.
nn <silent><nowait><M-c> :<C-u>CocList commands<cr>
" Find symbol of current document.
nn <silent><nowait><M-o> :<C-u>CocList outline<cr>
" Search workspace symbols.
nn <silent><nowait><M-s> :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nn <silent><nowait><M-j> :<C-u>CocNext<CR>
" Do default action for previous item.
nn <silent><nowait><M-k> :<C-u>CocPrev<CR>
" Resume latest coc list.
nn <silent><nowait><M-p> :<C-u>CocListResume<CR>
" }}}
" Applying codeAction to the selected region. {{{
" Example: `<leader>aap` for current paragraph
xm <silent>\a  <Plug>(coc-codeaction-selected)
nm <silent>\a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nm <silent>\ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nm <silent>\Q  <Plug>(coc-fix-current)
" }}}
" Show documentation in preview window. {{{
nn <silent>K :call <SID>show_documentation()<CR>
" }}}
" Map function and class text objects {{{
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap <silent><leader>f <Plug>(coc-format-selected)
nmap <silent><leader>f <Plug>(coc-format-selected)
xmap <silent>if        <Plug>(coc-funcobj-i)
omap <silent>if        <Plug>(coc-funcobj-i)
xmap <silent>af        <Plug>(coc-funcobj-a)
omap <silent>af        <Plug>(coc-funcobj-a)
xmap <silent>ic        <Plug>(coc-classobj-i)
omap <silent>ic        <Plug>(coc-classobj-i)
xmap <silent>ac        <Plug>(coc-classobj-a)
omap <silent>ac        <Plug>(coc-classobj-a)
" }}}
" }}}
" Insert Mode Mappings {{{

" Use tab for trigger completion with characters ahead and navigate.
ino <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
ino <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use <c-space> to trigger completion.
ino <silent><expr> <C-space> coc#refresh()

" Use complete_info() to confirm completion only when there's selected complete item (this allows for single-enter breaks)
if exists('*complete_info')
  ino <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif
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
  " Disable autocomplete
  au BufReadPost * let b:coc_suggest_disable = 0
aug END
"}}}
" Remap <C-f> and <C-b> for scroll float windows/popups. {{{
nn <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-f>"
nn <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-b>"
vn <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-f>"
vn <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-b>"
ino <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Right>"
ino <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Left>"
" }}}
" }}}
" editorconfig-vim {{{

let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']
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
      \ 'options': '--multi --reverse --preview "git diff HEAD^ HEAD {} | git-split-diffs --color | less -RFX" --preview-window "up,80%,rounded"',
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
" " nvim-bqf {{{

" " {{{
" " open           open the item under the cursor 										<CR>
" " openc          like open, and close quickfix window 							o
" " tab            open the item under the cursor in a new tab 				t
" " tabb           like tab, but stay at quickfix window 							T
" " split          open the item under the cursor in vertical split  	<C-x>
" " vsplit         open the item under the cursor in horizontal split	<C-v>
" " prevfile       go to previous file under the cursor 							<C-p>
" " nextfile       go to next file under the cursor 								 	<C-n>
" " prevhist       go to previous quickfix list 										 	<
" " nexthist       go to next quickfix list 													>
" " stoggleup      toggle sign and move cursor up 									 	<S-Tab>
" " stoggledown    toggle sign and move cursor down 								 	<Tab>
" " stogglevm      toggle multiple signs in visual mode 						 	<Tab>
" " stogglebuf     toggle signs for same buffers under the cursor 	 	'<Tab>
" " sclear         clear the signs in current quickfix list 					z<Tab>
" " pscrollup      scroll up half-page in preview window 							<C-b>
" " pscrolldown    scroll down half-page in preview window 						<C-f>
" " pscrollorig    scroll back to original postion in preview window	zo
" " ptogglemode    toggle preview window between normal and max size  zp
" " ptoggleitem    toggle preview for an item of quickfix list 			 	p
" " ptoggleauto    toggle auto preview when cursor moved 						 	P
" " filter         create new list for signed items 								  zn
" " filterr        create new list for non-signed items 						  zN
" " fzffilter      enter fzf mode 														        zf
" " }}}
" " Variables {{{

" let g:coc_enable_locationlist = 0
" " }}}
" " Functions {{{

" function! Coc_qf_jump2loc(locs) abort "{{{
"     let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
"     call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
"                 \ 'context': {'bqf': 
"                 \ {'lsp_ranges_hl': loc_ranges}
"                 \ }})
"     let winid = getloclist(0, {'winid': 0}).winid
"     if winid == 0
"         aboveleft lwindow
"     else
"         call win_gotoid(winid)
"     endif
" endfunction " }}}
" " }}}
" " Autocommands {{{

" aug Coc
"     au!
"     au User CocLocationsChange ++nested call Coc_qf_jump2loc(g:coc_jump_locations)
" aug END
" " }}}
" " }}}
" ranger.vim {{{

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=false"'

nn <silent>\e :RangerCurrentFile<cr>
" }}}
" vim-floaterm {{{

let g:floaterm_autoclose = 0
let g:floaterm_autohide = 0
let g:floaterm_title = '$2 term'
let g:floaterm_opener = 'edit'
let g:floaterm_position = 'center'
let g:floaterm_height = 0.9
let g:floaterm_width = 0.9

nnoremap   <silent>   <F7>   :FloatermNew<CR>
tnoremap   <silent>   <F7>   <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>   :FloatermPrev<CR>
tnoremap   <silent>   <F8>   <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>   :FloatermNext<CR>
tnoremap   <silent>   <F9>   <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F10>  :FloatermKill<CR>
tnoremap   <silent>   <F10>  <C-\><C-n>:FloatermKill<CR>
nnoremap   <silent>   <F12>  :FloatermToggle<CR>
tnoremap   <silent>   <F12>  <C-\><C-n>:FloatermToggle<CR>
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
let g:go_auto_type_info = 0
let g:go_diagnostics_level = 2
let g:go_doc_keywordprg_enabled = 1
let g:go_doc_popup_window = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
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
let g:go_info_mode = 'guru'
let g:go_list_type = 'quickfix'
let g:go_play_browser_command = "${BROWSER}"
let g:go_play_open_browser = 0
let g:go_statusline_duration = 1000
let g:go_test_show_name = 1
let g:go_test_timeout= '10s'
let g:go_updatetime = 0
let g:go_guru_scope = []

let $GINKGO_EDITOR_INTEGRATION = "true"
" }}}
" Mappings {{{

aug GO
  au!
  au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

  " gd - Goto definition.
  " C-t - Go back.
  " if, af - Function selectors.
  " [[, ]] - Move between functions.

  au FileType go nm <silent>'D :GoDeclsDir<cr>
  au FileType go nm <silent>'I :GoImports<cr>
  au FileType go nm <silent>'R :GoRename<cr>
  au FileType go nm <silent>'a :GoAlternate<cr>
  au FileType go nm <silent>'b :GoBuild<cr>
  au FileType go nm <silent>'c :GoCoverageToggle<cr>
  au FileType go nm <silent>'d :GoDecls<cr>
  au FileType go nm <silent>'e :GoDescribe<cr>
  au FileType go nm <silent>'E :GoWhicherrs<cr>
  au FileType go nm <silent>'f :GoFiles<cr>
  au FileType go vm <silent>'f :GoFreevars<cr>
  au FileType go nm <silent>'i :GoInfo<cr>
  au FileType go nm <silent>'r :GoRun<cr>
  au FileType go nm <silent>'p :GoImplements<cr>
  au FileType go vm <silent>'p :GoPeerChannels<cr>
  au FileType go nm <silent>'s :GoSameIdsToggle<cr>
  au FileType go nm <silent>'t :GoCallstack<cr>
  " Also, :GoCallees and :GoCallers.
  " au FileType go nm <silent>K :call CocActionAsync('doHover')<cr>
aug END
" }}}
" }}}
" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}
" vim-wheel {{{

let g:wheel#line#threshold = 1
let g:wheel#map#down       = '<PageDown>'
let g:wheel#map#mouse      = 1
let g:wheel#map#up         = '<PageUp>'
let g:wheel#scroll_on_wrap = 1
" }}}
" }}}

