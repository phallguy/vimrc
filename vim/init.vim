set shell=/bin/bash
set encoding=utf-8

let mapleader = "."

runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'     " Syntax error indicators
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'tpope/vim-surround'       " tags/quotes
Plug 'tpope/vim-dispatch'
Plug 'vim-scripts/tComment'     " Comment toggling
Plug 'vim-airline/vim-airline'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment' " Comments as text objects
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gcmt/taboo.vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'vim-scripts/ruby-matchit'
Plug 'vim-scripts/Conque-Shell' " Terminal in VIM
Plug 'skwp/vim-ruby-conque'     " Spec helpers
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/vim-blockle'
Plug 'alvan/vim-closetag'

Plug 'nginx/nginx', { 'rtp': 'contrib/vim' }

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
call plug#end()

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set number        " Always show line numbers
set nocursorline
set nocursorcolumn
set nostartofline " Keep the cursor on the same column
set ttyfast
set lazyredraw
set nowrap
set autoread
set switchbuf=usetab
set spell
" set iskeyword-=_
set autoindent
set smartindent
set showmatch     " Show matching pair of [] () {}

" MacVim Tweaks
set guioptions-=rL
set guifont=Source\ Code\ Pro\ Light:h14


if &t_Co > 2 || has("gui_running")
  set t_Co=256
  let base16colorspace=256
  set hlsearch
  "This unsets the "last search pattern" register by hitting return
  nnoremap <CR> :noh<CR><CR>
  set background=dark
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

  if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
  endif

  " Light background "papercolor"
  " set background=light
  " colorscheme paperColor
  " let g:airline_theme='papercolor'

  " Use the same color for closing tags as opening tags
  highlight link xmlEndTag xmlTag
endif

" custom commands

" Autosave
set autowriteall  " Save when switching buffers
augroup autosaveEx
  autocmd!

  au FocusLost,BufLeave * silent! :wa
augroup END

" Softtabs, 2 spaces
set shiftround
set expandtab
set textwidth=79
set formatoptions-=t
set tabstop=2
set softtabstop=2
set shiftwidth=2
if exists('&colorcolumn')
  let &colorcolumn="80,".join(range(120,999),",")
  highlight ColorColumn ctermbg=18
endif

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" tell it to use an undo file
set undofile
" you:uuuuset a directory to store the undo history
set undodir=$HOME/.vimundo/

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if has('mouse')
  set mouse=a
  " set ttymouse=xterm2
endif

" Keyboard tweaks
nnoremap <leader><leader> :tabe $MYVIMRC<cr>
" Make it easy to move around in insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv
nnoremap <C-a> ggVGG
" Quick window navigation
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
nnoremap <leader>dab :bufdo bd<CR>

" Expand spaces inside brackets/parens
let delimitMate_expand_space=1


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  endif
endif

augroup TrailingWhitespace
  autocmd!

  " Remove trailing whitespace on save for ruby files.
  function! s:RemoveTrailingWhitespaces()
    "Save last cursor position
    let l = line(".")
    let c = col(".")

    %s/\s\+$//ge

    call cursor(l,c)
  endfunction

  au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END


augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Atlasfile set filetype=ruby
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

let &titlestring = getcwd()
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term == "xterm" || &term == "xterm-256color" || &term == "nvim"
  set title
endif
augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

augroup nerdTreeEx
autocmd!

" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>

map <F9> :NERDTreeFind<CR>

let NERDTreeMapOpenInTab='<C-t>'
augroup END

" Snippets
let g:UltiSnipsSnippetsDir='~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"

"key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste
" Use OSX clipboard
set clipboard=unnamed

" FZF
nnoremap <leader>/ :BLines<CR>
nnoremap <C-P> :FZF<CR>
nnoremap <leader>, :Buffers<CR>
let $FZF_DEFAULT_COMMAND='ag -g ""'

" Ruby
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'hanging'

" Rails

map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "bo 15split | enew | call termopen( \"cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \\\"$CP\\\" ] ; do echo $CP; CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec)/..; echo 'Running specs...'; bin/rspec {spec}\" ) | startinsert | stopinsert"


" Javascript
let g:jsx_ext_required = 0

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx"
let g:closetag_emptyTags_caseSensitive = 1

" GIT
nnoremap <leader>d :Dispatch git dt %<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntatsic_filetype_map = { "javascript.jsx": "javascript" }
" let g:syntastic_debug = 33


let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

let g:syntastic_javascript_checkers = ["eslint"]


" Python
let python_highlight_all=1
augroup pythonEx
  autocmd!

  " https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
  au FileType python set tabstop=4
  au FileType python set softtabstop=4
  au FileType python set shiftwidth=4

augroup END

filetype plugin indent on