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

"plugins {
call plug#begin('~/.vim/plugged')
" Auto closes HTML tags
Plug 'alvan/vim-closetag'

" Makes every variable a different color
Plug 'jaxbot/semantic-highlight.vim'

" Automatically opens popup menu for completions as you type in insert mode
Plug 'plugged/AutoComplPop'

" Lightweight plugin to display tabs and buffers at the top of the screen
Plug 'pacha/vem-tabline'

" This plugin visual displays indent guides
Plug 'nathanaelkane/vim-indent-guides'

" This plugin highlights patterns and ranges for Ex commands in Command-line
" mode. It also provides live preview for :substitute.
Plug 'markonm/traces.vim'

call plug#end()
" }

" plugin options {
" set semantic highlight colors
let g:semanticTermColors = [1, 3, 5, 7, 9, 10, 12, 13, 15, 29, 30, 31, 32, 33, 35, 36, 37, 38, 39, 41, 42, 43, 44, 45, 46, 49, 50, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 244, 245, 246, 247, 248, 249, 250, 251, 253, 254, 255]

" set indent guides on startup
let g:indent_guides_enable_on_vim_startup = 1

" disable indent guides automatic colors
let g:indent_guides_auto_colors = 0

" set indent guides size
let g:indent_guides_guide_size = 1

" set indent level to start showing guides from
let g:indent_guides_start_level = 2

" set vem tabline to always show
let g:vem_tabline_show = 2

" set vem tabline to show numbers
"let g:vem_tabline_show_number = 'index'
" }

" options {
set noexpandtab           " dont use spaces when [Tab] is inserted
set relativenumber        " print the relative line number in front of each line
set autoindent            " take indent for new line from previous line
set smartindent           " smart autoindenting for C programs
set smarttab              " use shiftwidth when inserting [Tab]
set hidden                " Allows opening another buffer while the current buffer has unsaved work
set cursorline            " highlight the screen line of the cursor
set cursorlineopt=both    " Sets an option to cursorline to highlight the line and line number
set laststatus=2          " Sets when the last window will have a status line 
set foldcolumn=1          " Sets width of spaces to put by line numbers to show open/closed folds
set termwinsize=8x200     " sets size when opening the terminal window
set undofile              " makes every file have an undo file, to undo any changes even after reboot
"set showbreak=↪           " string to put at the start of lines that has been wrapped
set nowrap                " lines will not wrap
set showcmd               " show (partial) command in status line
set ruler                 " show cursor line and column in the status line 
set hlsearch              " highlight matches with last search pattern
" }

" keybinds {
noremap  <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

nnoremap <F12> <Esc>:SemanticHighlightToggle<CR>
inoremap <F12> <C-o>:SemanticHighlightToggle<CR>

noremap  <F7> <Esc>:bp<CR>
noremap  <F8> <Esc>:bn<CR>


" move selections
vnoremap  <C-S-Up>   :m'<-2<CR>gv=gv
vnoremap  <C-S-Down> :m '>+1<CR>gv=gv

noremap   <C-S-Up>   V :m'<-2<CR>gv=gv
noremap   <C-S-Down> V :m'>+1<CR>gv=gv


" Clear highlights on search when pressing <Esc> in normal mode
noremap <Esc> :nohlsearch<CR>

" }

" functions {

" enable semantic highlight function
fun! EnableSemantic()
  SemanticHighlight
  RebuildSemanticColors
endfun
" }

" autocommands and autogroups { 

" parses file from start making syntax highlighting accurate
autocmd FileType * syntax sync fromstart

" fixes AutoComplPop from not showing -- INSERT -- when pressing i in most cases
autocmd VimEnter * silent! unmap i

"force indents so file plugins dont overwrite it
augroup force_indents
  autocmd!
  autocmd VimEnter * set shiftwidth=2  " number of spaces to use for (auto)indent step
  autocmd VimEnter * set tabstop=2     " number of spaces that [Tab] in file uses
  autocmd VimEnter * set softtabstop=2 " number of spaces that [Tab] uses while editing
augroup END  

" remembers your folds when you leave and enter the file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" enables semantic for all filetypes except in blacklist and while typing in insert mode
augroup semantic_highlight
  autocmd!
  let blacklist = ['vim', 'txt', 'help','','html']
  autocmd FileType * if index(blacklist,&ft) < 0 | call EnableSemantic() | endif
  autocmd InsertCharPre * if index(blacklist,&ft) < 0 | call EnableSemantic() | endif
augroup END
" }

" color scheme {
colorscheme desert
hi! def link    EndOfBuffer Normal

" Background {
highlight Normal             term=underline              ctermbg=NONE
highlight CursorLine         term=underline              ctermbg=017
" }

" Line Numbers {
highlight LineNr             term=underline ctermfg=024  ctermbg=NONE
highlight CursorLineNr       term=underline ctermfg=075  ctermbg=017
" }

" Status Bar {
highlight StatusLine         term=underline ctermfg=045  ctermbg=020    
highlight StatusLineTerm     term=underline ctermfg=045  ctermbg=020    
highlight StatusLineNC       term=underline ctermfg=030  ctermbg=018   
highlight StatusLineTermNC   term=underline ctermfg=030  ctermbg=018   
" }

" Folds {
highlight Folded             term=underline ctermfg=040  ctermbg=017  
highlight FoldColumn         term=underline ctermfg=040  ctermbg=NONE  
" }

" UI {
highlight Visual             term=underline ctermfg=000  ctermbg=006   
highlight NonText            term=underline ctermfg=015  ctermbg=000   
highlight Todo               term=underline ctermfg=002  ctermbg=000     
" }

" plugin colors
highlight IndentGuidesOdd                               ctermbg=243
highlight IndentGuidesEven                              ctermbg=240
highlight VemTablineSelected                ctermfg=045 ctermbg=020
highlight VemTablineNormal                  ctermfg=030 ctermbg=019
" }

