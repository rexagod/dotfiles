" Author: @rexagod

" Misc. {{{

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

Plug 'ctrlpvim/ctrlp.vim' | Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }}}

" Internals {{{

Plug 'alok/notational-fzf-vim'
Plug 'aymericbeaumet/vim-symlink'
Plug 'vim-test/vim-test'
Plug 'Shougo/neomru.vim'
Plug 'voldikss/vim-floaterm'
Plug 'editorconfig/editorconfig-vim'
" }}}

" Navigation {{{

Plug 'phaazon/hop.nvim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
Plug 'rhysd/clever-f.vim'
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
"                                          *ac* *cac* *dac* *vac* *yac*
" ac     "a column", a column based on "a word" |aw|.
"                                          *ic* *cic* *dic* *vic* *yic*
" ic     "inner column", a column based on the "inner word" |iw|.
"                                          *aC* *caC* *daC* *vaC* *yaC*
" aC     "a COLUMN", a column based on "a WORD" |aW|.
"                                          *iC* *ciC* *diC* *viC* *yiC*
" iC     "inner COLUMN", a column based on "inner WORD" |iW|.
"}}}
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'flwyd/vim-conjoin'
Plug 'jiangmiao/auto-pairs'
" }}}

" Visuals {{{

Plug 'markonm/traces.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-peekaboo'
" }}}

" Syntax {{{

Plug 'romainl/Apprentice'
Plug 'NLKNguyen/papercolor-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
" }}}

call plug#end()
" }}}

" Theme {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
filetype indent on
filetype plugin on
syntax enable
set t_Co=256
set termguicolors

" set background=light
" let g:airline_theme = 'papercolor'
" colorscheme papercolor

" let g:airline_theme = 'apprentice'
" set background=dark
" colorscheme apprentice

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_italicize_strings=1
colorscheme gruvbox

" let g:jellybeans_use_term_italics = 1
" let g:jellybeans_use_lowcolor_black = 1
" colorscheme jellybeans
" }}}

" Statusline (vim-airline) {{{

" Listed all themes for autocompletion {{{
"     * alduin
"     * angr
"     * apprentice
"     * atomic
"     * ayu_light
"     * ayu_mirage
"     * ayu_dark
"     * badwolf
"     * base16 (|airline-theme-base16|)
"     * base16_vim (|airline-theme-base16_vim|)
"     * base16_shell (|airline-theme-base16_shell|)
"     * base16_3024
"     * base16_adwaita
"     * base16_apathy
"     * base16_ashes
"     * base16_atelier_cave
"     * base16_atelier_cave_light
"     * base16_atelier_dune
"     * base16_atelier_dune_light
"     * base16_atelier_estuary
"     * base16_atelier_estuary_light
"     * base16_atelier_forest
"     * base16_atelier_forest_light
"     * base16_atelier_heath
"     * base16_atelier_heath_light
"     * base16_atelier_lakeside
"     * base16_atelier_lakeside_light
"     * base16_atelier_plateau
"     * base16_atelier_plateau_light
"     * base16_atelier_savanna
"     * base16_atelier_savanna_light
"     * base16_atelier_seaside
"     * base16_atelier_seaside_light
"     * base16_atelier_sulphurpool
"     * base16_atelier_sulphurpool_light
"     * base16_atelierdune
"     * base16_atelierforest
"     * base16_atelierheath
"     * base16_atelierlakeside
"     * base16_atelierseaside
"     * base16_atlas
"     * base16_bespin
"     * base16_black_metal
"     * base16_black_metal_bathory
"     * base16_black_metal_burzum
"     * base16_black_metal_dark_funeral
"     * base16_black_metal_gorgoroth
"     * base16_black_metal_immortal
"     * base16_black_metal_khold
"     * base16_black_metal_marduk
"     * base16_black_metal_mayhem
"     * base16_black_metal_nile
"     * base16_black_metal_venom
"     * base16_brewer
"     * base16_bright
"     * base16_brogrammer
"     * base16_brushtrees
"     * base16_brushtrees_dark
"     * base16_chalk
"     * base16_circus
"     * base16_classic
"     * base16_classic_dark
"     * base16_classic_light
"     * base16_codeschool
"     * base16_colors
"     * base16_cupcake
"     * base16_cupertino
"     * base16_darktooth
"     * base16_decaf
"     * base16_default
"     * base16_default_dark
"     * base16_default_light
"     * base16_dracula
"     * base16_edge_dark
"     * base16_edge_light
"     * base16_eighties
"     * base16_embers
"     * base16_espresso
"     * base16_flat
"     * base16_framer
"     * base16_fruit_soda
"     * base16_gigavolt
"     * base16_github
"     * base16_google
"     * base16_google_dark
"     * base16_google_light
"     * base16_grayscale
"     * base16_grayscale_dark
"     * base16_grayscale_light
"     * base16_greenscreen
"     * base16_gruvbox_dark_hard (|airline-theme-base-gruvbox-dark-hard|)
"     * base16_gruvbox_dark_medium
"     * base16_gruvbox_dark_pale
"     * base16_gruvbox_dark_soft
"     * base16_gruvbox_light_hard
"     * base16_gruvbox_light_medium
"     * base16_gruvbox_light_soft
"     * base16_harmonic16
"     * base16_harmonic_dark
"     * base16_harmonic_light
"     * base16_heetch
"     * base16_heetch_light
"     * base16_helios
"     * base16_hopscotch
"     * base16_horizon_dark
"     * base16_horizon_light
"     * base16_horizon_terminal_dark
"     * base16_horizon_terminal_light
"     * base16_ia_dark
"     * base16_ia_light
"     * base16_icy
"     * base16_irblack
"     * base16_isotope
"     * base16_londontube
"     * base16_macintosh
"     * base16_marrakesh
"     * base16_materia
"     * base16_material
"     * base16_material_darker
"     * base16_material_lighter
"     * base16_material_palenight
"     * base16_material_vivid
"     * base16_mellow_purple
"     * base16_mexico_light
"     * base16_mocha
"     * base16_monokai
"     * base16_nord
"     * base16_nova
"     * base16_ocean
"     * base16_oceanicnext
"     * base16_one_light
"     * base16_onedark
"     * base16_outrun_dark
"     * base16_papercolor_dark
"     * base16_papercolor_light
"     * base16_paraiso
"     * base16_phd
"     * base16_pico
"     * base16_pop
"     * base16_porple
"     * base16_railscasts
"     * base16_rebecca
"     * base16_sandcastle
"     * base16_seti
"     * base16_shapeshifter
"     * base16_snazzy
"     * base16_solarflare
"     * base16_solarized
"     * base16_solarized_dark
"     * base16_solarized_light
"     * base16_spacemacs
"     * base16_summerfruit
"     * base16_summerfruit_dark
"     * base16_summerfruit_light
"     * base16_synth_midnight_dark
"     * base16_tomorrow
"     * base16_tomorrow_night
"     * base16_tomorrow_night_eighties
"     * base16_tube
"     * base16_twilight
"     * base16_vim
"     * base16_unikitty_dark
"     * base16_unikitty_light
"     * base16_woodland
"     * base16_xcode_dusk
"     * base16_zenburn
"     * base16color
"     * behelit
"     * biogoo
"     * bubblegum
"     * cobalt2
"     * cool
"     * dark
"     * dark_minimal
"     * desertink
"     * deus
"     * distinguished
"     * durant
"     * faryfloss
"     * fruit_punch
"     * google_dark
"     * google_light
"     * hybrid
"     * hybridline
"     * jay
"     * jellybeans
"     * jet
"     * kalisi
"     * kolor
"     * laederon
"     * lessnoise
"     * light
"     * lighthaus
"     * lucius
"     * luna
"     * minimalist (|airline-theme-minimalist|)
"     * molokai
"     * monochrome
"     * murmur
"     * night_owl
"     * nord-minimal
"     * onedark (|airline-theme-onedark|)
"     * ouo
"     * owo
"     * papercolor
"     * peaksea
"     * powerlineish
"     * qwq
"     * raven
"     * ravenpower
"     * seagull
"     * seoul256
"     * serene
"     * sierra
"     * silver
"     * simple
"     * soda
"     * sol
"     * solarized (|airline-theme-solarized|)
"     * solarized_flood
"     * term
"     * term_light
"     * tomorrow
"     * ubaryd
"     * understated
"     * violet
"     * wombat
"     * xtermlight
"     * zenburn
"     * transparent
" }}}
let airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#whitespace#checks = ['conflicts']
let g:airline#extensions#whitespace#enabled = 1
let g:airline_base16_improved_contrast = 1
let g:airline_inactive_alt_sep = 1
let g:airline_left_alt_sep = ""
let g:airline_left_sep = ""
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ""
let g:airline_right_sep = ""

function! SanitizeModified() " {{{
  if &modified
    return ' [+]'
  endif
  return ''
endfunction
" }}}
let g:airline_section_a = airline#section#create(['mode', 'iminsert'])
let g:airline_section_b = airline#section#create(['%{expand("%f")}', '%{SanitizeModified()}']) " Use <C-g> for a detailed view.
let g:airline_section_c = airline#section#create(['readonly'])
let g:airline_section_x = airline#section#create(['%{coc#status()} ', '⎇  %{fugitive#head()}'])
let g:airline_section_y = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create(['%l', ':', '%v', '  ', '%p', '%%'])
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
set autoindent
set autoread
set autowrite
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
set noincsearch
set noignorecase
set noshowmode
set nosmartcase
set noswapfile
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

ino   <C-j>         <esc>5ja
ino   <C-k>         <esc>5ka
ino   <C-h>         <esc>5ha
ino   <C-l>         <esc>5la
imap  <C-Right>     <esc>5la
imap  <C-Left>      <esc>5ha
imap  <C-Up>        <esc>5ka
imap  <C-Down>      <esc>5ja
imap  <C-PageUp>    <esc><C-b>a
imap  <C-PageDown>  <esc><C-f>a

ino   <S-Right>   <Nop>
ino   <S-Left>    <Nop>
ino   <S-Up>      <esc><C-e>a
ino   <S-Down>    <esc><C-y>a

ino   <PageUp>    <NOP>
ino   <PageDown>  <NOP>
" }}}

" Visual Mode Mappings {{{

vn    <C-j>        5j
vn    <C-k>        5k
vn    <C-h>        5h
vn    <C-l>        5l
vm    <C-Right>    <C-l>
vm    <C-Left>     <C-h>
vm    <C-Up>       <C-k>
vm    <C-Down>     <C-j>
vn    <C-PageUp>   <C-b>
vn    <C-PageDown> <C-f>

vn    <S-Right>   <Nop>
vn    <S-Left>    <Nop>
vn    <S-Up>      <C-e>
vn    <S-Down>    <C-y>

vn    <PageUp>    <NOP>
vn    <PageDown>  <NOP>

" }}}

" Normal Mode Mappings {{{

nn    <C-j>        5j
nn    <C-k>        5k
nn    <C-h>        5h
nn    <C-l>        5l
nm    <C-Right>    <C-l>
nm    <C-Left>     <C-h>
nm    <C-Up>       <C-k>
nm    <C-Down>     <C-j>
nn    <C-PageUp>   <C-b>
nn    <C-PageDown> <C-f>

nn    <S-Right>   <Nop>
nn    <S-Left>    <Nop>
nn    <S-Up>      <C-y>
nn    <S-Down>    <C-e>

nn    <silent><F2>    :messages<cr>
nn    <silent><F4>    :only<cr>
nn    <silent>QQ      :bd<cr>
nn    <F1>            <NOP>
nn    <PageUp>        <NOP>
nn    <PageDown>      <NOP>
" }}}

" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>zr        :vsp $MYZSHRC<cr>
nn <silent><leader>vr        :vsp ~/.config/nvim/init.vim<cr>
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

" auto-pairs {{{

" <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
" <BS>  : Delete brackets in pair
" <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
" <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
" <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
" <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)
" <M-(bracket)> : Put succeeding character after nearest (bracket).
" <M-;> : Jump to next closing bracket (of a pair).

let g:AutoPairsShortcutFastWrap = '<M-z>'
" }}}

" bclose.vim {{{

let g:bclose_no_plugin_maps=1
" }}}

" clever-f.vim {{{

" Alt.: hop.nvim, fzf.vim

" Use f<CR> to repeat previous search.

let g:clever_f_mark_direct = 1
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_chars_match_any_signs = ';' " f;
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

" Show documentation in preview window. {{{
nn <silent> K :call <SID>show_documentation()<CR>
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
" ino <silent><expr> <CR> pumvisible() ? "\<CR>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
ino <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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
      \   'options': '--preview="bat --color always --theme gruvbox-dark {}" --preview-window='.g:preview_window_fmt
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

" notational-fzf-vim {{{

nm \n :NV<cr>

let g:nv_search_paths = ['~/repositories/notes', './README.md']
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

" vim-floaterm {{{

nn    <silent>   <F6>    :FloatermNew<CR>
tno   <silent>   <F6>    <C-\><C-n>:FloatermNew<CR>
nn    <silent>   <F7>    :FloatermPrev<CR>
tno   <silent>   <F7>    <C-\><C-n>:FloatermPrev<CR>
nn    <silent>   <F8>    :FloatermNext<CR>
tno   <silent>   <F8>    <C-\><C-n>:FloatermNext<CR>
nn    <silent>   <F9>    :FloatermToggle<CR>
tno   <silent>   <F9>    <C-\><C-n>:FloatermToggle<CR>
nn    <silent>   <F10>   :FloatermKill<CR>
tno   <silent>   <F10>   <C-\><C-n>:FloatermKill<CR>
" }}}

" vim-go {{{

" Variables {{{

let g:go_auto_sameids = 0
let g:go_auto_type_info = 0
let g:go_diagnostics_level = 2
let g:go_doc_keywordprg_enabled = 0
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
let g:go_imports_autosave = 0
let g:go_info_mode = 'gopls'
let g:go_list_type = 'quickfix'
let g:go_play_browser_command = "chrome"
let g:go_play_open_browser = 0
let g:go_statusline_duration = 1000
let g:go_test_show_name = 1
let g:go_test_timeout= '10s'
let g:go_updatetime = 100
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
  au FileType go nm <silent>K :call CocActionAsync('doHover')<cr>

  " Alternate utilities to open alternate file in different ways.
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
aug END
" }}}

" "Etcetera etcetera" stuff that I prefer doing manually. {{{
" :GoImpl
" :GoPlay
" }}}
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
