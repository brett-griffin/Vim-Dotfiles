set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')
Plugin 'VundleVim/Vundle.vim'               " Let Vundle manage itself


" Vim Theme
Plugin 'ayu-theme/ayu-vim'                  " Vim colorcheme

" General Vim
Plugin 'tpope/vim-fugitive'                 " Vim Git wrapper
Plugin 'tpope/vim-vinegar'                  " Directory / file listing
Plugin 'scrooloose/nerdtree'                " Ctrl-T Open directory tree for the cwd
Plugin 'ctrlpvim/ctrlp.vim'                 " Fuzzy find files in the cwd
Plugin 'scrooloose/nerdcommenter'           " Comment the line from anywhere on the line (<leader>c<space>)
Plugin 'Yggdroot/indentLine'                " Show lines between the start and end of code blocks
Plugin 'tpope/vim-surround'                 " 's' as surround cs[( on [test] = ( test )
Plugin 'ervandew/supertab'                  " Make <tab> handle many tasks such as autocomplete, snippets etc
Plugin 'vim-airline/vim-airline'            " Airline status bar
Plugin 'vim-airline/vim-airline-themes'     " All the Airline themes
Plugin 'SirVer/ultisnips'                   " Powerful snippets (python required)
Plugin 'honza/vim-snippets'                 " Snippets used by ultisnips
Plugin 'Valloric/YouCompleteMe'             " Automated auto-completion (don't need to press <tab>)
Plugin 'vim-syntastic/syntastic'            " Runs external linting applications and makes them available in Vim 
Plugin 'junegunn/vader.vim'                 " Vimscript testing
" Plugin for replace in files

" Web Development
Plugin 'alvan/vim-closetag'                 " Auto-close HTML tags
Plugin 'shawncplus/phpcomplete.vim'         " PHP auto-completion (With UltiSnips/YCM use the key combo: <C-space>)
Plugin 'file:///home/g/Desktop/Projects/PHPDocBlocks.vim'  " PHPDocBlocks
Plugin 'othree/html5.vim'                   " HTML 5 syntax support
Plugin 'posva/vim-vue'                      " Vue syntax support
Plugin 'ap/vim-css-color'                   " CSS color codes
Plugin 'jwalton512/vim-blade'               " Blade syntax support

call vundle#end()            " required
filetype plugin indent on    " required

"====[ Notes ]==========================================
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

