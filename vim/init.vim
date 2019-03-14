set encoding=utf-8
set shell=/bin/bash

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing Experience
"
let mapleader = " "

set nobackup
set nowritebackup
set noswapfile     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
" set backupcopy=yes " Overwrite existing file so file watchers can detect changes
set noendofline     " Don't automatically add newline
set nofixendofline
set nofoldenable    " don't use folding

set cursorline      " Makes vim refresh much slower
set nocursorcolumn

" set synmaxcol=192   " Limit some of the impact of complex syntax regex
set foldmethod=indent
set regexpengine=1
set redrawtime=500

set hlsearch
set incsearch
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

set showcmd
set nostartofline " Keep the cursor on the same column
set lazyredraw    " Don't redraw screen while executing macros and such.
set nowrap

" Softtabs, 2 spaces
set shiftround
set expandtab
set textwidth=79
set formatoptions-=t
set formatoptions+=2c
set tabstop=2
set softtabstop=2
set shiftwidth=2
set preserveindent

" Line Numbers
set number        " Always show line numbers
set numberwidth=5

" https://stackoverflow.com/a/25276429/76456
" Make regex for ruby syntax faster
set re=1

set undofile                " tell it to use an undo file
set undodir=$HOME/.vimundo/ " use a directory to store the undo history


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"
call plug#begin('~/.vim/plugged')
  Plug 'MarcWeber/vim-addon-local-vimrc' " import .vimrc from CWD when launching
  Plug 'tpope/vim-obsession'    " Save and restore window/etc sessions

  " Visual experience
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " General editing
  Plug 'vim-scripts/tComment'     " Comment toggling
  Plug 'terryma/vim-multiple-cursors'
  Plug 'junegunn/vim-easy-align'  " Multi-line bock alignment
  Plug 'tpope/vim-surround'       " change surrounding tags/quotes/parens
  Plug 'SirVer/ultisnips'         " Code snippets
  Plug 'terryma/vim-expand-region'
  Plug 'ervandew/supertab'

  " Searching & navigation
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'

  " Git/status
  Plug 'tpope/vim-fugitive'       " Git integration
  Plug 'tpope/vim-rhubarb'        " More GitHub integration

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Language support
  "
  Plug 'kana/vim-textobj-user'    " Custom 'object' targeting for movements
  Plug 'glts/vim-textobj-comment' " Comments as text objects

  " Ruby/rails
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'thoughtbot/vim-rspec'
  Plug 'nelstrom/vim-textobj-rubyblock'

  " Javasript
  Plug 'sbdchd/neoformat'         " prettier/eslint formatting rules
  Plug 'leafgarland/typescript-vim'

  " Markdown
  Plug 'mzlogin/vim-markdown-toc'

  " Arduino
  Plug 'sudar/vim-arduino-syntax'
  Plug 'sudar/vim-arduino-snippets'

call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and visual styling
"
if &t_Co > 2 || has("gui_running")

  " Support 24-bit colors if possible
  if (has("termguicolors"))
    set termguicolors
  endif

  set background=dark

  if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
  endif

  let g:airline_powerline_fonts = 0
  let g:airline_section_a = airline#section#create([ 'mode' ])
  let g:airline_section_y = airline#section#create_right([ '#%{winnr()}' ])
  let g:airline_section_z = "%M %#__accent_bold#%4l/%L%#__restore__# %{g:airline_symbols.linenr} %3v"
  let g:airline_skip_empty_sections = 1
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

  let g:airline_highlighting_cache = 1
  let g:airline#extensions#whitespace#enabled = 0

endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window/navigation
"

" Window/tab management
set splitbelow
set splitright

set scrolloff=10     " Keep 10 lines at top/bottom of window when scrolling
set sidescrolloff=10

" Leave paste mode on exit
au InsertLeave * set nopaste

" Alias shortcuts for common tasks
nnoremap <leader>rc :tabe $MYVIMRC<cr>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>n :cn<CR>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>le
nnoremap <Left>  :vertical resize -2<CR>

" Quick window navigation
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhi

augroup nerdTreeEx
  autocmd!

  " Toggle nerdtree with F10
  map <F10> :NERDTreeToggle<CR>

  map <F9> :NERDTreeFind<CR>

  let NERDTreeMapOpenInTab='<C-t>'
  let NERDTreeMinimalUI=1
  let NERDTreeDirArrows=1
  let NERDTreeIgnore=['node_modules']
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General editing commands.
"

" Cliboards
set clipboard=unnamedplus " Use OSX clipboard

" Move lines up/down
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv
nnoremap <C-a> ggVGG

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Session management
augroup sourcesession

  " Reload previously saved session on startup
  autocmd!
  autocmd VimEnter * nested
  \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
  \   source Session.vim |
  \ endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END

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

set autowriteall    " Save when switching buffers

augroup autosaveEx
  autocmd!

  au FocusLost,BufLeave * silent! update
augroup END

" Snippets
let g:UltiSnipsSnippetsDir='~/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching & file navigation
"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --path-to-ignore\ .agignore

  command! -nargs=+ -complete=file Ag silent! grep! <args>|cwindow|redraw!
endif

" FZF
nnoremap <leader>/ :BLines<CR>
nnoremap <C-P> :FZF<CR>
nnoremap , :Buffers<CR>
let $FZF_DEFAULT_COMMAND='ag -g "" --path-to-ignore .agignore'


augroup buffersEx
  autocmd!


  command! CloseBuffers %bd|e#
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Per file/syntax customization
"

augroup syntaxOverrides
  autocmd!

  autocmd BufRead,BufNewFile Jakefile,*.jake,*.ejs set filetype=javascript
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile Dockerfile.erb set filetype=dockerfile
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile *.aurora set filetype=python
  autocmd BufRead,BufNewFile tsconfig.json set filetype=typescript

  " https://stackoverflow.com/a/34153085/76456
  let ruby_no_expensive=1

augroup END

" Use the same color for closing tags as opening tags
highlight link xmlEndTag xmlTag

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'


" Git commit messages
augroup gitEx
  autocmd!

  au FileType gitcommit set tw=100
  au FileType gitcommit set nonumber
augroup END

" Show diff of current file in external tool
nnoremap <leader>d :!cd %:h; git dt %:p<CR>

" VIMRC
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Ruby/Rails
" Rails
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>
map <leader>x :bd! .rspec-output<CR>
map <space><space> :bd! .rspec-output<CR>
map <leader>r :AV<CR>

if has('nvim') || exists("g:gui_oni")
  let g:rspec_command = "silent! bd! .rspec-output | bo 30split | enew | call termopen( \"cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \\\"$CP\\\" ] ; do echo $CP;  CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec); echo 'Running specs...'; cd ..; ([ -x bin/rspec_runner ] && bundle exec bin/rspec_runner {spec}) || bundle exec bin/rspec {spec}\" ) | set bufhidden=hide | file .rspec-output"
else
  let g:rspec_command = "!cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \"$CP\" ] ; do echo $CP; CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec)/..; echo 'Running specs...'; bin/rspec {spec}"
endif

let g:rails_console_command = "echo no command set"
nnoremap <leader>c :silent! bd! .rails-console \| bo 30split \| enew \| file .rails-console \| call termopen( g:rails_console_command ) \| set bufhidden=hide<CR>
nnoremap <leader>m :silent! bd! .console \| bo 30split \| enew \| file .console \| term bash -l<CR>


" JavaScript

" let g:neoformat_verbose = 0

augroup jsNeoformat
  autocmd!

  function! FindPrettier()
    let a:src = expand( '%:p' )
    let a:cmd = 'cd $( find `( SPEC=''' . a:src . '''; CP=${SPEC%/*}; while [ -n "$CP" ] ; do echo $CP; CP=${CP%/*}; done; echo / )` -mindepth 1 -maxdepth 1 -type d -name node_modules ); pwd'
    let a:node_modules = StrTrim( system( a:cmd ) )

    let g:neoformat_javascript_prettier = {
            \ 'exe': a:node_modules . '/.bin/prettier',
            \ 'args': ['--stdin', '--stdin-filepath', '%:p'],
            \ 'stdin': 1,
            \ }

    let g:neoformat_typescript_prettier = {
            \ 'exe': a:node_modules . '/.bin/prettier',
            \ 'args': ['--stdin', '--stdin-filepath', '%:p'],
            \ 'stdin': 1,
            \ }
  endfunction

  function! StrTrim(txt)
    return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  endfunction

  autocmd FileType javascript call FindPrettier()
  autocmd FileType typescript call FindPrettier()

  autocmd BufWritePre *.ts Neoformat
  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.jsx Neoformat

augroup END


" Adrduino

augroup ArduinoEx
  autocmd!


  command! Amake lcd %:p:h|make upload
augroup END

" Support per-project .vimrc commands
set exrc
set secure