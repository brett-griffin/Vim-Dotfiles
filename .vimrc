"====[ Project Configuration ]==========================
cd ~/Desktop/App/
let excludedir = "node_modules,vendor,PhoneGap,storage,dist,public"
let includefiletypes = "php,js,vue,html,css"

" TODO: Make separate projects so the local exec is set automatically or at least the cwd is
" TODO: frontend / backend projects
" Use local eslint (use .eslintrc.js to define 'standard' style and html plugin for .vue files)
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = "./Quasar/node_modules/.bin/eslint"
" Set filetype to: vue.javascript specifically! So Vim-Vue can highlight and Syntastic can lint
augroup vueFileType
    autocmd!
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.javascript
augroup END

"====[ Vim Configuration ]==============================
source ~/.vim/plugins.vim                               " Source plugins file
let g:indentLine_char = '¦'                             " Character to use between start and end of code blocks
set laststatus=2                                        " Display airline all the time
let g:airline_theme='murmur'                            " Airline Colour Theme
let g:pdv_template_dir = "~/.vim/pdv-snips"             " Custom PHP documentor snippets file

set fileformat=unix                                     " Unix line endings only
set fileformats=unix,mac,dos                            " Handle Mac and DOS line endings, new files get Unix endings
set encoding=utf-8                                      " Default encoding Vim will use
set so=998                                              " Keep the cursor in the center of the screen
set tags+=./tags                                        " Find the tags file here
set backspace=indent,eol,start                          " Make backspace work like normal
set shellslash                                          " Forward slashes for MS Windows
set pastetoggle=<F2>                                    " Toggle raw paste
set mouse=""                                            " Disable moving the cursor with the mouse

let mapleader = "\<space>"                              " Leader key
nnoremap <space> <nop>

set updatetime=500                                      " Trigger CursorHold every Xms
" Auto reload/save files on window focus and after an inactive cursor for 'updatetime' (default 4000ms)
" Also, auto SyntasticCheck
augroup saveReloadFile
    autocmd!
    autocmd FocusGained,BufEnter * silent! !
    autocmd CursorHold,CursorHoldI * silent! w | SyntasticCheck
augroup END

" Keep sign column open so Syntastic doesn't keep indenting
augroup keepSignColumnOpen
    autocmd!
    autocmd BufWinEnter * sign define mysign
    autocmd BufWinEnter * exe "sign place 1337 line=1 name=mysign buffer=" . bufnr('%')
augroup END

set list                                                " Show whitespace characters
execute "set listchars=tab:\uBB\uBB,nbsp:~,trail:\uBF"

set textwidth=0                                         " Break the line after n characters (0 = never break)
set wrapmargin=0                                        " Used when text-wdith is set to 0. Counts characters from the RIGHT of screen.

set noerrorbells visualbell t_vb=                       " Remove the error sound and screen flash (autocmd for gVim)
augroup visualBells
    autocmd!
    autocmd GUIEnter * set visualbell t_vb=
augroup END

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000             " Store a lot of history information

" TODO: Make the directories auto-create on new systems
" No backup or swap files in project directories
if exists("*mkdir")
    if !isdirectory($HOME."/.vim_backup/backup")
        call mkdir($HOME."/.vim_backup/backup", "p")
    endif
    if !isdirectory($HOME."/.vim_backup/swap")
        call mkdir($HOME."/.vim_backup/swap", "p")
    endif
    if !isdirectory($HOME."/.vim_backup/undo")
        call mkdir($HOME."/.vim_backup/undo", "p")
    endif
endif
set backupdir=~/.vim_backup/backup//
set directory=~/.vim_backup/swap//
set undodir=~/.vim_backup/undo//

"====[ Auto-Completion & Snippets ]=====================
augroup autoComplete
    autocmd!
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType php setlocal completefunc=phpcomplete#CompletePHP
augroup END
set completeopt=longest,menuone                         " Options for auto-completion popup menu
set complete=.,w,b,u                                    " Where to look for completions (current file, windows, buffers, unloaded buffers)

" Compatibility between ycm, supertab and ultisnips
let g:ycm_key_list_select_completion   = ['<c-j>', '<C-n>', '<down>']
let g:ycm_key_list_previous_completion = ['<c-k>', '<C-p>', '<up>']
let g:SuperTabDefaultCompletionType    = '<c-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = "<tab>"
let g:UltiSnipsJumpForwardTrigger      = "<tab>"
let g:UltiSnipsJumpBackwardTrigger     = "<s-tab>"

"====[ Maximise and Fullscreen ]========================
" Maximising before fullscreen makes it so the command line in vim does not increase in size when you save a file (weird bug)
noremap <silent><f11> :call system("wmctrl -ir " . v:windowid . " -b add,maximized_vert,maximized_horz")<cr>:call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<cr>

" Maximize gVim on when it starts
augroup autoMaximise
    autocmd!
    autocmd GUIEnter * call system("wmctrl -ir " . v:windowid . " -b add,maximized_vert,maximized_horz")
augroup END

"====[ Laravel ]========================================
nnoremap <leader>Lm :!php artisan make:
nnoremap <leader>lr :CtrlP getcwd()<cr>routes/
nnoremap <leader>lc :CtrlP getcwd()<cr>app/Http/Controllers/
nnoremap <leader>lv :CtrlP getcwd()<cr>resources/views/
nnoremap <leader>lp :CtrlP getcwd()<cr>app/Providers
nnoremap <leader>lm :CtrlP getcwd()<cr>.*app/\w*\.php

"====[ Tab Handling ]===================================
                                                        " :retab will convert tabs to spaces
set tabstop=4                                           " Tab indentation levels every four columns
set shiftwidth=4                                        " Indent/outdent by four columns
set expandtab                                           " Convert all tabs that are typed into spaces
set shiftround                                          " Always indent/outdent to nearest tabstop
set smarttab                                            " Shiftwidths at left margin, tabstops everywhere else
augroup tabstops
    autocmd!
    autocmd BufRead,BufNewFile *.js,*.vue,*.html setlocal shiftwidth=2 tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
augroup END

"====[ Auto Correct ]===================================
iab flase false f

"====[ Window Management ]==============================
set splitbelow                                          " Horizontal splits go underneath
set splitright                                          " Vertical splits go to the right

"====[ Search ]=========================================
set hlsearch                                            " Highlight all matches when Enter is pressed
set incsearch                                           " Search as you type, instead of after Enter is pressed
set ignorecase                                          " Ignore case in all searches...
set smartcase                                           " ...unless uppercase letters used

" Search in files using grep
execute "command! -nargs=1 GrepInCWD :silent grep -Ri --exclude-dir={".excludedir."} --include=\*.{".includefiletypes."} <q-args> ".getcwd()
nnoremap <leader>g :GrepInCWD 
" Quick fix window on all grep commands
augroup autoQuickFix
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

" Use :CtrlPClearAllCache or F5 to refresh when you update custom ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  'vendor$\|node_modules$\|PhoneGap$',
  \ 'file': '',
  \ 'link': '',
  \ }
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30,results:30'
let g:ctrlp_regexp_search = 1

"====[ Replace ]========================================
execute "command! -nargs=1 GFindReplace :%s/<args>/gc"
nnoremap <leader>r :GFindReplace<space>

"====[ Theme Settings ]=================================
syntax enable                                           " Enable syntax highlighting
colorscheme ayu                                         " Set the color scheme
let ayucolor = "dark"                                   " Ayu Theme colors

set guifont=Ubuntu\ Mono\ 11                            " Set font and font size
set guioptions-=l                                       " Remove always present left scroll bar
set guioptions-=L                                       " Remove split window left scroll bar
set guioptions-=r                                       " Remove always present right scroll bar
set guioptions-=R                                       " Remove split window right scroll bar
set guioptions-=T                                       " Removes the toolbar from gvim
set guioptions-=M                                       " Removes the menubar from gvim

set number                                              " Line numbers
set relativenumber                                      " Shows line numbers relative to the cursor
set linespace=6                                         " gVim line height - messes with airline arrows if not 0

highlight LineNr guibg=bg
highlight foldcolum guibg=bg
highlight vertsplit guifg=bg guibg=bg
highlight MatchParen guibg=#333333 guifg=#dddddd
highlight SignColumn guibg=bg

" Mark line at 101 chars if a character exists there
highlight ColorColumn ctermbg=red ctermfg=white guibg=#491919
call matchadd('ColorColumn', '\%101v', 100)
" Fix a couple of problems with new windows not using the colorcolumn
augroup overLengthInAllBuffers
    autocmd!
    autocmd BufEnter,WinEnter * highlight ColorColumn ctermbg=red ctermfg=white guibg=#491919
    autocmd BufEnter,WinEnter * call matchadd('ColorColumn', '\%101v', 100)
augroup END

"====[ Mappings ]=======================================
" Unmapping: unmap or iunmap | Use non-recursive mappings (nnoremap)
" Weird things happen if there is white space after a map command
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>ev :e ~/.vim/.vimrc<cr>
nnoremap <leader>ep :e ~/.vim/plugins.vim<cr>
execute "command! -nargs=0 EditSnippets :execute ':e ~/.vim/UltiSnips/'.&ft.'.snippets'"
nnoremap <leader>es :EditSnippets<cr>
nnoremap <leader>esa :e ~/.vim/UltiSnips/all.snippets<cr>

nnoremap <leader><bs> :nohlsearch<cr>
nnoremap <leader>w :w<cr> :e<cr> :echo "Saved!"<cr>

nnoremap <cr> G
nnoremap <bs> gg
noremap <c-a> ggVG

nnoremap <c-t> :NERDTreeToggle<cr>

nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>or :CtrlPMRUFiles<cr>
noremap <leader>o :CtrlP getcwd()<cr>

nnoremap <esc> :cclose<cr>
nnoremap <c-j> :silent! cnext<cr>
nnoremap <c-k> :silent! cprevious<cr>

nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprevious<cr>
nnoremap <leader><leader> :b#<cr>

nnoremap <s-tab> <<
inoremap <s-tab> <c-d>
nnoremap <tab> >>

nnoremap <leader>p "+p
nnoremap <leader>y "+y
nnoremap <leader>yy "+y
vnoremap <leader>y "+y

nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>doc :call PHPDoc#insert()<cr>

nnoremap <silent><leader>fix :silent !php-cs-fixer fix "%" --rules=@PSR2<cr>

nnoremap <leader>num :set relativenumber!<cr>

"====[ Auto Commands ]==================================
" Auto source the vimrc and plugins.vim when saved
augroup autoSourceVimFiles
    autocmd!
    autocmd BufwritePost .vimrc source %
    autocmd BufwritePost plugins.vim call AutoPluginInstall()
    function! AutoPluginInstall()
        source %
        :PluginInstall
        :PluginClean!
        :hide
    endfunction
augroup END

"====[ Notes ]==========================================
" Universal ctags for linux:
" git clone https://github.com/universal-ctags/ctags
" sudo apt-get install autoconf autogen
" ./autogen.sh
" ./configure
" make
" sudo make install
" cd ~/Desktop/App
" ctags -R --exclude=node_modules --exclude=PhoneGap

" Grey borders hack fix:
" e: ~/.vim/.gtkrc-2.0
" add (match theme colour):
" style "vim-bg-fix" {
"   bg[NORMAL] = "#222222"
" }
" widget "vim-main-window.*GtkForm" style "vim-bg-fix"
" Put ~/.gtkrc-2.0 into ~/.vim/ for version control, then link:
" ln -s ~/.vim/.gtkrc-2.0 ~/.gtkrc-2.0

" PHP Formatter (php-cs-fixer):
" composer global require friendsofphp/php-cs-fixer
" export PATH="$PATH:$HOME/.composer/vendor/bin"

" Caps lock as Esc and Control:
" gnome-tweak-tool: Typing >> Ctrl key position >> Caps Lock as Control
" sudo apt-get install xcape
" Open 'Startup Applications'
" Add >> Command >> xcape -e '#66=Escape'

" Put .vimrc into ~/.vim/ for version control, then link:
" ln -s ~/.vim/.vimrc ~/.vimrc

"====[ Resources ]======================================

