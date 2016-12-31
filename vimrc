set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-fugitive'

Plugin 'stanangeloff/php.vim'

Plugin 'scrooloose/syntastic'

Plugin 'valloric/youcompleteme'

call vundle#end()
filetype plugin indent on

"UI"
set number				"Show line numbers
set showcmd				"Show command in bottom bar
set wildmenu			"Visual autocomplete for command menu

"Color"
colorscheme elflord		"Color scheme
set background=dark		"Background Color 

"General"
set showmatch			"Highlight matching brace
set textwidth=90		"Line wrap
set autoread			"Auto read externally changed file
set ffs=unix,dos,mac	"Unix as standard file type

"Editor"
set autoindent			"Auto-indent new lines
set shiftwidth=4		"Number of auto indent width
set smartindent			"Smart indent
set smarttab			"Smart tab
set softtabstop=4		"Soft Tab
set tabstop=4			"Tab visual spaces
syntax enable			"Syntax Highlighting

"Searching" 
set incsearch			"Search as characters are entered
set hlsearch			"Highlight search matches
set ignorecase			"Ignore cases when searching
set smartcase			"Attempt smart case searching if possible


"Custom Functions"
"Highlights text that surpasses 90th column
highlight OverLength ctermbg=darkgrey ctermfg=white guibg=#FFD9D9
match OverLength /\%>90v.\+/

"Vim-Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v']) 
set laststatus=2
let g:airline_theme='bubblegum'
