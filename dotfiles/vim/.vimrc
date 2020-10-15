set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" Vim guttere: A Vim plugin which shows a git diff in the 'gutter' (sign column).
Plugin 'airblade/vim-gitgutter'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Porting of the monomak theme for vim
Plugin 'molokai'

" Autocomplete engine, might require additional config
Plugin 'valloric/youcompleteme'

" Plugin to surround text
Plugin 'tpope/vim-surround'

" File explorer
Plugin 'scrooloose/nerdtree'

" To comment stuff (default leader key is '\')
Plugin 'scrooloose/nerdcommenter'

" Status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Another color theme
Plugin 'nanotech/jellybeans.vim'

"Plugin 'sickill/vim-monokai'
Plugin 'crusoexia/vim-monokai'

" Search any file
Plugin 'ctrlpvim/ctrlp.vim'


" Show buffers at the bottom of the screen
Plugin 'bling/vim-bufferline'

" Use multiple cursors
Plugin 'terryma/vim-multiple-cursors'

" Bookmarks
Plugin 'MattesGroeger/vim-bookmarks'

" Smart code folding for python
Plugin 'tmhedberg/SimpylFold'

" Tagbar
Plugin 'majutsushi/tagbar'

" PEP8 checker
Plugin 'nvie/vim-flake8'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Alternative cpp highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'

" Python mode
Plugin 'python-mode/python-mode'

" Jinja syntax highlighting
Plugin 'Glench/Vim-Jinja2-Syntax'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Cool icons for file types
Plugin 'ryanoasis/vim-devicons'

" JSX syntax highlighting
Plugin 'yuezk/vim-js'
Plugin 'maxmellon/vim-jsx-pretty'

" Black formatter for python
Plugin 'psf/black'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use molokai color scheme for the editor
"colorscheme molokai
colorscheme monokai

" Use molokai theme for the airline
let g:airline_theme='powerlineish'
" Also uses powerline fonts
let g:airline_powerline_fonts = 1

" YCM: autoclose docs window after insertion/completion
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Use current virtualenv python for autocompletion
let g:ycm_python_binary_path = 'python'

" Enable powerline for tabs as well!
let g:airline#extensions#tabline#enabled = 1

" Open NERDTree when vim starts
"autocmd vimenter * NERDTree

" Open NERDTree when a folder is opened
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Highlight active buffer
autocmd VimEnter * let g:bufferline_active_buffer_left = '['
autocmd VimEnter * let g:bufferline_active_buffer_right = ']'

set nofoldenable

" Forces text wrapping at 80 characters
set textwidth=80

" Two mappings for easy tab navigation
nnoremap tt  :tabedit<Space>
nnoremap td  :tabclose<CR>

set updatetime=1000

" Toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" Map CTRL+/ to toggle comment (for some reason vim requires _ instead of /)
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" Set tabs to be 4 spaces
set ts=4 sw=4 sts=4 et

" Quick save with <Leader>s
noremap <Leader>s :update<CR>

" :Gwrite with <Leader>w
noremap <Leader>w :Gwrite<CR>

" :Gstatus with <Leader>e
noremap <Leader>e :Gstatus<CR>

" Set syntax check mode for python to python3 (python-mode)
let g:pymode_python = 'python3'

" Ignore certain errors/warnings:
" E116 - inconsistent indentation on commented line
" E402 - import not at top of file
" E722 - bare except
let g:pymode_lint_ignore = ["E116", "E402", "E722"]
let g:pymode_options_colorcolumn = 1
let g:pymode_options_max_line_length = 88

" Enable rope
let g:pymode_rope = 1
let g:pymode_rope_goto_definition_cmd = 'tabedit'

" Had to disable this due to bad interaction with multi cursors
" Check while editing
"let g:pymode_lint_on_fly = 1

" Also check if save but not modified
let g:pymode_lint_unmodified = 0

" Ignore certain types of files
set wildignore+=*.o,*.so,*.swp,*.zip     " MacOSX/Linux

" Enable FixIt for Youcompleteme
map <F9> :YcmCompleter FixIt<CR>

" Mappings for fuzzy finder
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Start fuzzy search in files
map <c-x><c-f> :Ag<CR>
