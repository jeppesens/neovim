" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
    Plug 'tpope/vim-sensible'
    Plug 'junegunn/seoul256.vim'
    Plug 'dracula/vim'
    Plug 'preservim/nerdtree'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'airblade/vim-gitgutter'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'kiteco/vim-plugin'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'prettier/vim-prettier'
    Plug 'pangloss/vim-javascript'
    Plug 'w0rp/ale'
    Plug 'tmux-plugins/vim-tmux-focus-events' " Restore focus events when inside tmux
    Plug 'psliwka/vim-smoothie' " Smooth scrolling in vim
    Plug 'tomtom/tcomment_vim' " Comment stuff out easily
    Plug 'mattn/emmet-vim' " Makes writing HTML and CSS much easier
    Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
    Plug 'ervandew/supertab' " Use <Tab> for autocompletion in insert mode
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"Config Section
if (has('termguicolors'))
 set termguicolors
endif
syntax enable
colorscheme dracula


"Nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['node_modules', '.git']
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
function! ToggleNERDTree()
  :if exists("b:NERDTree") && b:NERDTree.IsOpen()
    call g:NERDTree.ForCurrentTab().getRoot().refresh() | call g:NERDTree.ForCurrentTab().render()
    :set nonumber
  :else
    :set number
  :endif
  :NERDTreeToggle
endfunction
nnoremap <silent> <C-b> :call ToggleNERDTree()<CR>

" dev-icons
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" FZF
" `brew install fzf`
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
" nnoremap <C-p> :FZF<CR>
" et g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Buffers<CR>
" `brew install ripgrep`
nnoremap <C-f> :Rg<CR>


" intellisense
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0


" kite
let g:kite_supported_languages = ['python']


" tab navigation
" Tab navigation like Firefox.
" nnoremap <C-a> :tabprevious<CR>
nnoremap <C-a>   :tabnext<CR>

"terminal
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
  :set nonumber
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>



" Linting
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers['javascript'] = ['eslint']

" Fix files automatically on save
let g:ale_fix_on_save = 1


" other
" c-s to save
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
:set number
set tabstop=4 shiftwidth=4 expandtab