" Plugin list
call plug#begin('~/.config/nvim/plugins') " Pluging folder

Plug 'tpope/vim-commentary' " Plugin with quick comments
Plug 'tpope/vim-surround'   " Plugin for quick surrounding
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Nodejs extensions
Plug 'preservim/nerdtree' " Filesystem explorer
Plug 'ctrlpvim/ctrlp.vim' " File finder
Plug 'tpope/vim-fugitive' " Advanced git support
Plug 'markonm/traces.vim' " Immediate change when substituting
Plug 'joshdick/onedark.vim' " onedark
Plug 'sheerun/vim-polyglot' " Syntax highlighting
Plug 'lervag/vimtex' " LaTeX stuff
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic highlighting
Plug 'fatih/vim-go' " Go support
Plug 'jaxbot/semantic-highlight.vim' " Semantic highlighting
Plug 'sebdah/vim-delve' " Delve support
Plug 'itchyny/lightline.vim' " Status line

call plug#end() " End of plugin declaration

" Colorscheme setup
" colorscheme gruvbox
colorscheme onedark

" set background=dark
set termguicolors
set number
set relativenumber

syntax on

set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a

filetype plugin indent on

set colorcolumn=80

" Language
set linebreak
highlight lCursor guifg=NONE guibg=Cyan
setlocal spell spelllang=ru_yo,en_us
set keymap=russian-jcukenmac
set iminsert=0
set imsearch=0

let g:tex_flavor = 'latex'
let g:vimtex_compiler_engine = 'lualatex'
let g:vimtex_view_general_viewer = 'zathura'

" Functions

" Type helpers
let mapleader = "\<space>"

inoremap <> <><esc>i
inoremap () ()<esc>i
inoremap [] []<esc>i
inoremap {} {}<esc>i
inoremap '' ''<esc>i
inoremap "" ""<esc>i
inoremap $$ $$<esc>i
inoremap `` ``<esc>i
au Filetype python inoremap __ __<Esc>i
au Filetype python inoremap ____ ____<Esc>hi
" au Filetype python nnoremap <silent> <leader>es :e /usr/local/lib/python3.9/site-packages/matplotlib/mpl-data/stylelib/afonin.mplstyle<cr>

au FileType go nnoremap <silent> <leader>db :DlvToggleBreakpoint<cr>
au FileType go nnoremap <silent> <leader>dt :DlvToggleTracepoint<cr>
au FileType go nnoremap <silent> <leader>dd :DlvDebug<cr>

nnoremap <silent> <leader>n :NERDTree<cr>
nnoremap <silent> <leader>m :noh<cr>
nnoremap <silent> <leader>s :set spell!<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>
inoremap <c-u> <esc>hgUiwea

noremap <Leader>y "*y
noremap <Leader>p "*p

tnoremap <Esc> <C-\><C-N>
nnoremap <leader>t <c-w>s<c-w>j:terminal<cr>i

inoremap <c-o> <esc>O

au BufWinLeave *.* mkview!
au BufWinEnter *.* silent! loadview
" au Filetype tex autocmd BufWritePre * ++once VimtexCompile

" Lightline setup
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
        \ 'right': [
            \ ['lineinfo'],
            \ ['fileformat', 'fileencoding', 'filetype'],
        \ ],
        \ 'left': [
            \ ['mode', 'paste'],
            \ ['gitbranch', 'readonly', 'filename', 'modified']
        \ ]
      \ },
    \ 'component_function': {
        \ 'gitbranch': 'FugitiveHead'
    \ }
\ }

"
" Coc
"
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=\ %f\ %y\ %m

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ad  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <leader>c   :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o   :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <leader>s   :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <leader>j   :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <leader>k   :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <leader>p   :<C-u>CocListResume<CR>

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

let g:coc_default_semantic_highlight_groups = 1

let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-vimlsp',
    \ 'coc-html',
    \ 'coc-vimtex',
    \ 'coc-sh',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-cmake',
    \ 'coc-clangd',
    \ 'coc-omnisharp',
    \ 'coc-go',
\ ]

" let g:OmniSharp_server_use_mono = 1
" let g:ale_linters = {
" \ 'cs': ['OmniSharp']
" \}
