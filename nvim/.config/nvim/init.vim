" Maintainer: @rexagod

" Plugins {{{

call plug#begin('~/.vim/plugged')
" coc.nvim {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}
" Go {{{

Plug 'ctrlpvim/ctrlp.vim' | Plug 'fatih/vim-go', { 'branch': 'master', 'do': ':GoUpdateBinaries' }
" }}}
" Git {{{

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'aacunningham/vim-fuzzy-stash'
" }}}
" Internals {{{

Plug 'nvim-lua/plenary.nvim'
Plug 'aymericbeaumet/vim-symlink'
Plug 'gelguy/wilder.nvim'
Plug 'romgrk/fzy-lua-native'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'voldikss/vim-floaterm'
" }}}
" Navigation {{{

Plug 'phaazon/hop.nvim'
Plug 'preservim/vim-wheel'
Plug 'dhruvasagar/vim-open-url'
Plug 'tpope/vim-unimpaired'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
Plug 'Shougo/neomru.vim' | Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim' | Plug 'chengzeyi/fzf-preview.vim'
Plug 'rhysd/clever-f.vim'
" }}}
" Text Manipulations {{{

" Plug 'preservim/vim-wordchipper'
Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-swap'
Plug 'kana/vim-textobj-user' | Plug 'coderifous/textobj-word-column.vim' | Plug 'adolenc/vim-textobj-toplevel'
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
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'flwyd/vim-conjoin'
" }}}
" Visuals {{{

Plug 'junegunn/vim-peekaboo'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'markonm/traces.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}
" Syntax {{{

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" }}}
" Themes {{{

Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'
" }}}
call plug#end()
" }}}
" Theme {{{
" Configuration {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
filetype indent on
filetype plugin on
syntax on
set t_Co=256
set termguicolors
" }}}

let g:gruvbox_contrast_dark     = 'light'
let g:gruvbox_contrast_light    = 'light'
let g:gruvbox_hls_cursor        = 'fg4'
let g:gruvbox_improved_strings  = '1'
let g:gruvbox_improved_warnings = '1'
let g:gruvbox_invert_selection  = '0'
let g:gruvbox_invert_tabline    = '0'
let g:gruvbox_italic            = '1'
let g:gruvbox_italicize_strings = '1'
let g:gruvbox_number_column     = 'bg0'
let g:gruvbox_sign_column       = 'bg0'
" set background="light"
colorscheme gruvbox

" let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 1
" let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai
" let g:airline_theme = 'sonokai'
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
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#exclude_preview = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 0
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
let g:airline#extensions#whitespace#checks = ['conflicts']
let g:airline#extensions#whitespace#enabled = 1
let g:airline_base16_improved_contrast = 1
let g:airline_inactive_alt_sep = 0
let g:airline_left_alt_sep = "\ue0b9"
let g:airline_left_sep = "\ue0b8"
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = "\ue0bb"
let g:airline_right_sep = "\ue0ba"

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
let g:airline_section_z = airline#section#create(['%l', ':', '%v  ', '%p', '%%'])
" }}}
" Variables {{{

let g:markdown_fenced_languages = ["vim","lua","javascript","typescript","go"]
" }}}
" Functions {{{

function! s:ToggleQuickFixList() " {{{
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    6copen
  else
    cclose
  endif
endfunction
" }}}
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
" }}}
" Options {{{

" set grepprg=rg\ --vimgrep
set autoindent
set autoread
set autowrite
set backupcopy=yes
set clipboard+=unnamedplus
set conceallevel=0
set confirm
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
set ssop=blank,buffers,curdir,folds,help,tabpages,winsize
set tabstop=2
set tags=
set textwidth=0
set undodir=~/.vim-undo-dir
set undofile
set updatetime=100
set wildmenu
set wildmode=longest,full
set pumblend=30
" }}}
" Maps {{{

" Insert Mode Mappings {{{

ino   <esc>         <C-c>
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

vn    <PageUp>    <Nop>
vn    <PageDown>  <Nop>

vn    <C-s>       :sort<cr> " implicitly inserts the visual marker range

" }}}
" Normal Mode Mappings {{{

nn    j              gj
nn    k              gk

nn    <Left>         h
nn    <Right>        l

nn    <C-j>          5j
nn    <C-k>          5k
nn    <C-h>          5h
nn    <C-l>          5l
nm    <C-Right>      <C-l>
nm    <C-Left>       <C-h>
nm    <C-Up>         <C-k>
nm    <C-Down>       <C-j>
nn    <C-PageUp>     2j
nn    <C-PageDown>   2k

nn    <S-Right>      <Nop>
nn    <S-Left>       <Nop>
nn    <S-Up>         <C-y>
nn    <S-Down>       <C-e>

nn    <silent><F4>   :only<cr>
nn    <silent><F5>   :messages<cr> "<F26> == <C-F2>
nn    <silent>QQ     :bd<cr>
nn    <F1>           <NOP>
" nn    <PageUp>       <NOP>
" nn    <PageDown>     <NOP>
" }}}
" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>zr        :vsp $ZSHRC<cr>
nn <silent><leader>vr        :vsp $VIMRC<cr>
nn <silent><nowait><leader>h :set hls!<bar>set is!<cr>:echo &hls &is<cr>
nn <silent><nowait><leader>q :silent! call <SID>ToggleQuickFixList()<cr>
nn <silent><nowait><leader>s :silent! exec <SID>SourceScriptImplicit()<cr>
" }}}
" }}}
" Autocommands {{{

aug FOO
  au!
  au BufWritePost * silent! !ctags -R &
  au Filetype *.js,*.ts setl suffixesadd=.js,.ts,.jsx,.tsx
  au Filetype *.js,*.ts,*.jsx,*.tsx nm = <leader>f
  au Filetype help,qf nn <silent><buffer>q :q<cr>
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  au ColorScheme * highlight Comment cterm=italic gui=italic
aug END
" }}}
" Commands {{{

command! CC :let b:coc_suggest_disable = 1
command! CI PlugClean | PlugInstall
command! CM delm!
command! QQ qall
command! SS mks! ~/.session.vim
command! W w
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
" clever-f.vim {{{

" Alt.: hop.nvim, fzf.vim

" Use f<CR> to repeat previous search.

let g:clever_f_mark_direct = 1
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_chars_match_any_signs = ';' " f;
" }}}
" coc.nvim {{{

" coc-snippets {{{

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
let g:coc_snippet_next = '<c-l>'

" Use <leader>x for convert visual selected code to snippet
xm <leader>x  <Plug>(coc-convert-snippet)
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

inoremap <silent><expr> <c-space> coc#refresh()

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
nm \Q  <Plug>(coc-fix-current)
"}}}

" Show documentation in preview window. {{{
nn <silent> K :call <SID>show_documentation()<CR>
"}}}

" Map function and class text objects{{{
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"}}}
"}}}

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
"}}}
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
      \ 'source': 'git show --format=oneline --name-only | tail --lines=+2', 
      \ 'sink': 'e',
      \ 'options': '--multi --reverse --preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {}"'
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

nn <silent><M-w> :HopWord<cr>
nn <silent><M-1> :HopChar1<cr>
nn <silent><M-2> :HopChar2<cr>
nn <silent><M-l> :HopLine<cr>
" }}}
" nvim-treesitter {{{

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF
" }}}
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

command! GS GStashList
command! GSL GStashList

let g:fuzzy_stash_actions = {
  \ 'ctrl-d': 'drop',
  \ 'ctrl-p': 'pop',
  \ 'ctrl-a': 'apply' }
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
let g:go_imports_autosave = 1
let g:go_info_mode = 'guru'
let g:go_list_type = 'quickfix'
let g:go_play_browser_command = "chromium"
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
  au FileType go nm <silent>K :call CocActionAsync('doHover')<cr>
aug END
" }}}
" }}}
" vim-indent-guides {{{

let g:indent_guides_enable_on_vim_startup = 0

command! II IndentGuidesToggle
" }}}
" vim-open-url {{{

nm gx gB
" }}}
" vim-peekaboo {{{

let g:peekaboo_window="vert bo ". winwidth(0)/2 . "new"
let g:peekaboo_compact=0
" }}}
" vim-swap {{{

" g<, g>, and gs
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)
" }}}
" vim-wheel {{{

let g:wheel#map#up   = '<PageUp>'
let g:wheel#map#down = '<PageDown>'
let g:wheel#map#mouse = 1
let g:wheel#line#threshold = 5
let g:wheel#scroll_on_wrap = 1
" }}}
" wilder.nvim {{{

call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('use_python_remote_plugin', 0)

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'use_python': 0,
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#lua_fzy_filter(),
      \     }),
      \     wilder#vim_search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': wilder#lua_fzy_highlighter(),
      \   'left': [
      \     wilder#popupmenu_devicons(),
      \   ],
      \   'right': [
      \     ' ',
      \     wilder#popupmenu_scrollbar(),
      \   ],
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': wilder#lua_fzy_highlighter(),
      \ }),
      \ }))
" }}}
" }}}
