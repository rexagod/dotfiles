" Maintainer: @rexagod

" Plugins {{{

call plug#begin('~/.vim/plugged')
" Internal {{{

" LSP {{{

Plug 'hrsh7th/cmp-nvim-lsp' | Plug 'hrsh7th/cmp-buffer' | Plug 'hrsh7th/cmp-path' | Plug 'hrsh7th/cmp-cmdline' | Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'
" }}}
" nvim-treesitter {{{

Plug 'nvim-treesitter/nvim-treesitter'
" }}}
Plug 'aymericbeaumet/vim-symlink'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'voldikss/vim-floaterm'
" }}}

" Go {{{

Plug 'ctrlpvim/ctrlp.vim' | Plug 'fatih/vim-go', { 'branch': 'master', 'do': ':GoUpdateBinaries' }
" }}}
" Git {{{

Plug 'aacunningham/vim-fuzzy-stash'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
" }}}
" Navigation {{{

Plug 'Shougo/neomru.vim' | Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} | Plug 'junegunn/fzf.vim' | Plug 'chengzeyi/fzf-preview.vim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'preservim/vim-wheel'
Plug 'rbgrouleff/bclose.vim' | Plug 'francoiscabrol/ranger.vim'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-unimpaired'
" }}}
" Text Manipulations {{{

Plug 'editorconfig/editorconfig-vim'
Plug 'flwyd/vim-conjoin'
Plug 'godlygeek/tabular'
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
Plug 'kana/vim-textobj-user' | Plug 'coderifous/textobj-word-column.vim' | Plug 'adolenc/vim-textobj-toplevel'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" }}}
" Visuals {{{

Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
" }}}
" Themes {{{

Plug 'arcticicestudio/nord-vim'
" needs to be loaded after all plugins have been initialized to patch w/o
" changing the current font, visit
" https://powerline.readthedocs.io/en/master/installation/linux.html#fontconfig
" prefer this over 'ryanoasis/vim-devicons', since apparently this supports a
" wider render range
Plug 'kyazdani42/nvim-web-devicons'
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

let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1

augroup nord-overrides
  autocmd!
  autocmd ColorScheme nord highlight Comment ctermfg=12 guifg=#EBCB8B
  autocmd ColorScheme nord highlight CursorLineNR cterm=bold
  autocmd ColorScheme nord highlight Folded cterm=italic,bold ctermbg=0 ctermfg=12 guibg=#3B4252 guifg=#81A1C1
  autocmd ColorScheme nord highlight clear CursorLine
augroup END

colorscheme nord
" }}}
" Statusline (vim-airline) {{{

" List all themes for autocompletion: alduin, angr, apprentice, atomic, ayu_light, ayu_mirage, ayu_dark, badwolf, base16 (|airline-theme-base16|), base16_vim (|airline-theme-base16_vim|), base16_shell (|airline-theme-base16_shell|), base16_3024, base16_adwaita, base16_apathy, base16_ashes, base16_atelier_cave, base16_atelier_cave_light, base16_atelier_dune, base16_atelier_dune_light, base16_atelier_estuary, base16_atelier_estuary_light, base16_atelier_forest, base16_atelier_forest_light, base16_atelier_heath, base16_atelier_heath_light, base16_atelier_lakeside, base16_atelier_lakeside_light, base16_atelier_plateau, base16_atelier_plateau_light, base16_atelier_savanna, base16_atelier_savanna_light, base16_atelier_seaside, base16_atelier_seaside_light, base16_atelier_sulphurpool, base16_atelier_sulphurpool_light, base16_atelierdune, base16_atelierforest, base16_atelierheath, base16_atelierlakeside, base16_atelierseaside, base16_atlas, base16_bespin, base16_black_metal, base16_black_metal_bathory, base16_black_metal_burzum, base16_black_metal_dark_funeral, base16_black_metal_gorgoroth, base16_black_metal_immortal, base16_black_metal_khold, base16_black_metal_marduk, base16_black_metal_mayhem, base16_black_metal_nile, base16_black_metal_venom, base16_brewer, base16_bright, base16_brogrammer, base16_brushtrees, base16_brushtrees_dark, base16_chalk, base16_circus, base16_classic, base16_classic_dark, base16_classic_light, base16_codeschool, base16_colors, base16_cupcake, base16_cupertino, base16_darktooth, base16_decaf, base16_default, base16_default_dark, base16_default_light, base16_dracula, base16_edge_dark, base16_edge_light, base16_eighties, base16_embers, base16_espresso, base16_flat, base16_framer, base16_fruit_soda, base16_gigavolt, base16_github, base16_google, base16_google_dark, base16_google_light, base16_grayscale, base16_grayscale_dark, base16_grayscale_light, base16_greenscreen, base16_gruvbox_dark_hard (|airline-theme-base-gruvbox-dark-hard|), base16_gruvbox_dark_medium, base16_gruvbox_dark_pale, base16_gruvbox_dark_soft, base16_gruvbox_light_hard, base16_gruvbox_light_medium, base16_gruvbox_light_soft, base16_harmonic16, base16_harmonic_dark, base16_harmonic_light, base16_heetch, base16_heetch_light, base16_helios, base16_hopscotch, base16_horizon_dark, base16_horizon_light, base16_horizon_terminal_dark, base16_horizon_terminal_light, base16_ia_dark, base16_ia_light, base16_icy, base16_irblack, base16_isotope, base16_londontube, base16_macintosh, base16_marrakesh, base16_materia, base16_material, base16_material_darker, base16_material_lighter, base16_material_palenight, base16_material_vivid, base16_mellow_purple, base16_mexico_light, base16_mocha, base16_monokai, base16_nord, base16_nova, base16_ocean, base16_oceanicnext, base16_one_light, base16_onedark, base16_outrun_dark, base16_papercolor_dark, base16_papercolor_light, base16_paraiso, base16_phd, base16_pico, base16_pop, base16_porple, base16_railscasts, base16_rebecca, base16_sandcastle, base16_seti, base16_shapeshifter, base16_snazzy, base16_solarflare, base16_solarized, base16_solarized_dark, base16_solarized_light, base16_spacemacs, base16_summerfruit, base16_summerfruit_dark, base16_summerfruit_light, base16_synth_midnight_dark, base16_tomorrow, base16_tomorrow_night, base16_tomorrow_night_eighties, base16_tube, base16_twilight, base16_vim, base16_unikitty_dark, base16_unikitty_light, base16_woodland, base16_xcode_dusk, base16_zenburn, base16color, behelit, biogoo, bubblegum, cobalt2, cool, dark, dark_minimal, desertink, deus, distinguished, durant, faryfloss, fruit_punch, google_dark, google_light, hybrid, hybridline, jay, jellybeans, jet, kalisi, kolor, laederon, lessnoise, light, lighthaus, lucius, luna, minimalist (|airline-theme-minimalist|), molokai, monochrome, murmur, night_owl, nord-minimal, onedark (|airline-theme-onedark|), ouo, owo, papercolor, peaksea, powerlineish, qwq, raven, ravenpower, seagull, seoul256, serene, sierra, silver, simple, soda, sol, solarized (|airline-theme-solarized|), solarized_flood, term, term_light, tomorrow, ubaryd, understated, violet, wombat, xtermlight, zenburn, transparent
" {{{
let airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#buf_label_first = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#exclude_preview = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_close_button = 0
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
let g:airline_symbols_ascii = 1
" }}}

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
let g:airline_section_x = airline#section#create(['%{nvim_treesitter#statusline()}', ' ⎇  %{fugitive#head()}'])
let g:airline_section_y = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create(['%l', ':', '%v  ', '%p', '%%'])
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

nm    <tab>          ]b 
nm    <s-tab>        [b

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
nn    <silent><F2>   :messages<cr>
nn    <silent>QQ     :bd<cr>
nn    <F1>           <NOP>

nn    <Tab> <C-w>l
nn    <S-Tab> <C-w>h
" }}}
" Leader Mappings {{{

let mapleader="\<Space>"

nn <silent><leader>gs        :enew $GOSANDBOX<cr>
nn <silent><leader>vr        :vsp $VIMRC<cr>
nn <silent><leader>zr        :vsp $ZSHRC<cr>
nn <silent><leader>tr        :vsp $TMUXRC<cr>
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
  au BufNewFile,BufRead * if @% =~ "Dockerfile" | setl filetype=dockerfile | endif
  au Filetype help,qf nn <silent><buffer>q :q<cr>
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
  au ColorScheme * highlight Comment cterm=italic gui=italic
aug END
" }}}
" Commands {{{

command! CI PlugClean | PlugInstall
command! CM delm!
command! QQ qall
command! S w | source %
command! SS mks! ~/.session.vim
command! W w | e
command! YY PlugUpgrade | PlugClean | PlugInstall | PlugUpdate 
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
let g:clever_f_fix_key_direction = 0

let g:clever_f_chars_match_any_signs = ';' " f;
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
" goyo.vim {{{

let g:goyo_width="80"
let g:goyo_height="85%"
let g:goyo_linenr="0"
" }}}
" limelight.vim {{{

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" }}}
" nvim-bqf {{{

" {{{

" open           open the item under the cursor 										<CR>
" openc          like open, and close quickfix window 							o
" tab            open the item under the cursor in a new tab 				t
" tabb           like tab, but stay at quickfix window 							T
" split          open the item under the cursor in vertical split  	<C-x>
" vsplit         open the item under the cursor in horizontal split	<C-v>
" prevfile       go to previous file under the cursor 							<C-p>
" nextfile       go to next file under the cursor 								 	<C-n>
" prevhist       go to previous quickfix list 										 	<
" nexthist       go to next quickfix list 													>
" stoggleup      toggle sign and move cursor up 									 	<S-Tab>
" stoggledown    toggle sign and move cursor down 								 	<Tab>
" stogglevm      toggle multiple signs in visual mode 						 	<Tab>
" stogglebuf     toggle signs for same buffers under the cursor 	 	'<Tab>
" sclear         clear the signs in current quickfix list 					z<Tab>
" pscrollup      scroll up half-page in preview window 							<C-b>
" pscrolldown    scroll down half-page in preview window 						<C-f>
" pscrollorig    scroll back to original postion in preview window	zo
" ptogglemode    toggle preview window between normal and max size  zp
" ptoggleitem    toggle preview for an item of quickfix list 			 	p
" ptoggleauto    toggle auto preview when cursor moved 						 	P
" filter         create new list for signed items 								  zn
" filterr        create new list for non-signed items 						  zN
" fzffilter      enter fzf mode 														        zf
" }}}
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
aug END
" }}}
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

" Neovide {{{

let g:neovide_refresh_rate=75
let g:neovide_transparency=1
let g:neovide_no_idle=v:true
" }}}
" }}}
" LSP Configurations {{{

" LSP {{{

lua << EOF
local nvim_lsp = require('lspconfig')
-- on_attach {{{
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- }}}
end
-- Initialize LSPs {{{
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'bashls',
  'cmake',
  'cssls',
  'cssmodules_ls',
  'diagnosticls',
  'dockerls',
  'eslint',
  'golangci_lint_ls',
  'gopls',
  'html',
  'jsonls',
  'sumneko_lua',
  'texlab',
  'tsserver',
  'vimls',
  'yamlls',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
-- }}}
-- lsp_signature.nvim {{{
require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 20, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = " ",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  max_height = 50, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "shadow"   -- double, rounded, single, shadow, none
  },
  transparency = 20, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
})
-- }}}
EOF
" LSP commands {{{

command! ES EslintFixAll
" }}}
" LSP maps {{{

nn <silent>\A <cmd>lua vim.lsp.buf.code_action()<CR>
nn <silent>\a <cmd>lua vim.lsp.buf.range_code_action()<CR>
nn <silent>\D <cmd>lua vim.lsp.buf.document_symbol()<CR>
nn <silent>\d <cmd>lua vim.diagnostic.open_float()<CR>
nn <silent>\F <cmd>lua vim.lsp.buf.formatting()<CR>
nn <silent>\f <cmd>lua vim.lsp.buf.range_formatting()<CR>
nn <silent>\i <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nn <silent>\o <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nn <silent>\q <cmd>lua vim.diagnostic.setloclist()<CR>
nn <silent>K  <cmd>lua vim.lsp.buf.hover()<CR>
nn <silent>Z  <cmd>lua vim.lsp.buf.signature_help()<CR>
nn <silent>[z <cmd>lua vim.diagnostic.goto_prev()<CR>
nn <silent>]z <cmd>lua vim.diagnostic.goto_next()<CR>
nn <silent>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nn <silent>gR <cmd>lua vim.lsp.buf.rename()<CR>
nn <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nn <silent>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nn <silent>gr <cmd>lua vim.lsp.buf.references()<CR>
nn <silent>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
" }}}
" }}}
" nvim-cmp {{{

lua <<EOF
  -- Setup nvim-cmp {{{
  local cmp = require'cmp'
  -- Used for Super-TAB behavior emulation.
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end
  cmp.setup({
  -- }}} 
  -- Mappings {{{
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,

      ['<S-Tab>'] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
    },
    -- }}}
    -- Sources {{{
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/`
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
  -- }}}
  -- Setup lspconfig {{{
  local servers = {
    'bashls',
    'cmake',
    'cssls',
    'cssmodules_ls',
    'diagnosticls',
    'dockerls',
    'eslint',
    'golangci_lint_ls',
    'gopls',
    'html',
    'jsonls',
    'tsserver',
    'vimls',
    'yamlls',
  }

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities
    }
  end
  -- }}}
  -- lspkind-nvim {{{

  local lspkind = require('lspkind')
  cmp.setup {
    formatting = {
      format = lspkind.cmp_format({
        with_text = true, -- show metadata alongside icons
      })
    }
  }
  -- }}}
EOF
" }}}
" }}}
" nvim-treesitter {{{

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", 
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

