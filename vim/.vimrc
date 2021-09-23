filetype plugin on
filetype indent on

set number
set ruler
set scrolloff=5
set showmatch
set cursorline

" tabs
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab

" lang specific
au FileType go setl expandtab!
au FileType yaml setl sw=2 sts=2 ts=2
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.go set filetype=go


" folding
set foldnestmax=5
set nofoldenable
set foldlevel=1

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <C-L> :nohl<CR><C-L>

" indent
set autoindent
set smartindent


" mappings
noremap ; :
noremap s <C-W>
noremap j gj
noremap k gk

" special chars
set listchars=eol:¬,tab:>-,trail:█,extends:>,precedes:-
set list

" strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" PLUGIN CONFIGURATION
"
"
" run source ~/.vimrc :PlugInstall
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'fatih/vim-go'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()

" play nice editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" colors
syntax on
set t_Co=256
colorscheme jellybeans
highlight Normal guibg=black guifg=white
set background=dark

" syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_args = "--disable=missing-docstring --disable--disable=invalid-name --disable=line-too-long"
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']
let g:syntastic_ignore_files = ['\m\c\.cc$']
let g:go_fmt_command = "gofmt"
let g:go_fmt_options = "-s"

" Nerd tree shit
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" tab complete for u complete me
function! Tab_Or_Complete()
        if col('.')>1 && strpart( getline('.'), col('.')-2, 3) =~ '^\w'
            return "\<C-N>"
        else
            return "\<Tab>"
        endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"
set autochdir
