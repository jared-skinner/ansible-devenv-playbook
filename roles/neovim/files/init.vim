" This is a nvim rc file ment for a *nix system.  It has the following
" requirements:
"
"	1.	custom hybrid material theme for gvim
"		included in this repo as hm.vim
"
"	2.	the DejaVu Sans Mono for Powerline font
"		https://github.com/powerline/fonts
"
"	3.	plug package manager
"		https://github.com/junegunn/vim-plug
"
"	4.	fzf for fuzzy find on EVERYTHING!
"		https://github.com/junegunn/fzf
"
"	5.	Ag (a.k.a. the silver sercher)
"		https://github.com/ggreer/the_silver_searcher
"
"	6.	vim-latex
"		http://vim-latex.sourceforge.net/index.php?subject=download&title=Download

"	7.	YouCompleteMe
"		cmake is needed for compilation and a binary of llvm-clan is necessary
"		for fancy c syntax support.  Once these things are in place a compiled
"		component of the plugin needs to be build instructions below:
"		http://valloric.github.io/YouCompleteMe/

" UI Config {{{
set modelines=1					" check end of file for folding instructions
set number						" this sets line numbers
set showcmd						" we probably won't need this
set cursorline					" highlight current line
set wildmenu					" visual auto complete for command menu
set wildmode=list:longest		" When more than one match, list all matchas and complete till longest common string
set lazyredraw					" redraw only when we need to.
set showmatch					" when passing over a bracket, briefly jump to matching bracket.
set guioptions-=T				" remove tool bar
set guioptions-=m				" remove menu bar
set guioptions-=r				" remove right scrollbar
set guioptions-=L				" remove left scrollbar
set ruler						" keep track for row/column
set titlestring=%{getcwd()}		" set the window title to the PWD
set hidden						" buffers remain in memory when switching to a different one
set history=10000				" : command line history
set wrap! linebreak nolist		" set wrap options for when wrap is toggled
set hlsearch					" highlight words when searching (turn this off with return)
set autoread
set list
set listchars=tab:▶\ ,eol:¬		" show tabs and EOL as characters
set tabstop=4					" number of visual spaces per TAB
set softtabstop=4				" number of spaces in tab when editing
set shiftwidth=4				" this is for justification using > and <
set grepprg=grep\ -nH\ $		" set grep for .tex reference completion
set scrolloff=3
"set cindent

filetype plugin on				" needed for vim-latex
filetype indent on				" load file type specific indent files
filetype off					" required

au FocusLost * silent! wa		" save all windows on lose focus

au SwapExists *.* let v:swapchoice = 'e'


" enter insert mode any time focus is put on a terminal
autocmd BufWinEnter,WinEnter term://* startinsert

" exit normal mode when leaving a term
autocmd BufLeave term://* stopinsert


"let g:chromatica#libclang_path='/opt/clang/lib'

" }}}
" Folding {{{
set nofoldenable			" disable folding
"set foldlevelstart=10	" start folding then we are 10 blocks deep
"set foldnestmax=1		" 10 nested fold max
"set foldmethod=syntax	" fold based on indent level
" }}}
" Remaps {{{
" navigate between buffers using tab and shift+tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" use jk for exiting insert mode
inoremap jk <esc>

" return turns off search highlighting
nnoremap <CR> :set hlsearch! hlsearch?<CR>

" space open/closes folds
nnoremap <space> za

" toggle spell check
map <F7> :setlocal spell! spelllang=en_us<CR>

" save and compile latex
nnoremap <F2> :w<CR><leader>ll

map <C-n> :NERDTreeToggle<CR>

"jk to go to normal mode when in term mode
tnoremap jk <C-\><C-n>

"easy navigation to and from ternimal in NVim
tnoremap <C-w> <C-\><C-n><C-w>

nmap <F8> :TagbarToggle<CR>

"map <C-j> <Plug>(easymotion-bd-w)
" }}}
" Leader Shortcuts {{{
" leader is comma
let mapleader=","

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" edit vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" edit zshrc
nnoremap <leader>ez :vsp ~/.zshrc<CR>

" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" open ag.vim **note, the space at the end is there for a reason!
nnoremap <leader>a :Find 

" next tab
nnoremap <leader><TAB> :tabnext<CR>

" previous tab
nnoremap <leader><S-TAB> :tabprevious<CR>

" new tab using current buffer
nnoremap <leader>n :tabe %<CR>

" close tab
nnoremap <leader>c :tabclose<CR>

" toggle wrap, specal symbols dissappear when wrap is toggled, so this reset symbols
nnoremap <leader>w :set wrap! linebreak nolist <CR> :set list <CR> :set listchars=tab:▶\ ,eol:¬ <CR>

" save/update session
nnoremap <leader>m :call MakeSession()<CR>

" fold everything
nnoremap <leader>f :%foldc<CR>

" search tags
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :BTags<CR>
" }}}
" Plugins {{{
let path=$HOME.'/.nvim/autoload/'

call plug#begin(path)
	Plug 'Valloric/YouCompleteMe'			" better tab completion
	Plug 'bling/vim-airline'				" cool window decoration
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-fugitive'				" git wrapper for vim
	Plug 'mhinz/vim-signify'				" this can be used as a gutter for git, svn and cvs
	Plug 'rking/ag.vim'						" better global search
	Plug 'sjl/gundo.vim'					" tree undo history
	Plug 'moll/vim-bbye'					" close buffers without messing with window layout
	Plug 'justinmk/vim-syntax-extra'		" more syntax highlighting
	Plug 'kshenoy/vim-signature'			" show marks
	Plug 'hdima/python-syntax'				" better python syntax
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'					" fantastically fast fuzzy find
	Plug 'scrooloose/nerdtree'				" browse files while vimming
	Plug 'ryanoasis/vim-devicons'
	Plug 'neomake/neomake'					" async syntax checking
	Plug 'rhysd/vim-crystal'				" crystal lang syntax highlighting
	Plug 'critiqjo/lldb.nvim'				" debugging support
call plug#end()
" }}}
" FZF Settings {{{
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

map <C-p> :Files .<CR>
" }}}
" Neomake Settings {{{

let g:neomake_c_enabled_makers = ['gcc', 'clang']
let g:neomake_cpp_enabled_makers = ['gcc']
let g:neomake_c_clang_args = ['-std=c89', '-fsyntax-only', '-I/opt/osi/OpenNet_6.5.3.0/monarch/src/include', '-I/opt/osi/OpenNet_6.5.3.0/monarch/src/opennet/include/', '-DLINUX', '-DUNIX', '-D_REENTRANT', '-fPIC', '-DOSI64']
let g:neomake_c_gcc_args = ['-std=c89', '-fsyntax-only', '-I/opt/osi/OpenNet_6.5.3.0/monarch/src/include', '-I/opt/osi/OpenNet_6.5.3.0/monarch/src/opennet/include/', '-DLINUX', '-DUNIX', '-D_REENTRANT', '-fPIC', '-DOSI64']

autocmd! BufWritePost * call Make_and_copy()
function! Make_and_copy()
	NeomakeSh python /opt/scripts/filesync.py -f %:p
	NeomakeSh python /opt/scripts/update_ctags.py %:p
	Neomake
endfunction

" }}}
" YouCompleteMe settings {{{
	let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
	let g:ycm_show_diagnostics_ui = 0
	let g:ycm_register_as_syntastic_checker = 1
	let g:ycm_disable_for_files_larger_than_kb = 180
" }}}
" Signify Settings {{{
    nmap <leader>gj <plug>(signify-next-hunk)
    nmap <leader>gk <plug>(signify-prev-hunk)
" }}}
" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
"}}}
" Custom Functions {{{

" Go away and Come back.  This script auto saves session info and loads it.

" Get cwd string
function! GetCwdString()
	let a:cwd_string = getcwd()
	let a:cwd_string = substitute(a:cwd_string, '/', '', '')
	let a:cwd_string = substitute(a:cwd_string, '/', '_', 'g')
	let a:cwd_string = substitute(a:cwd_string, ' ', '_', 'g')
	let a:cwd_string = substitute(a:cwd_string, '\', '_', 'g')

	return a:cwd_string
endfunction

" Creates a session
function! MakeSession()
	let a:cwd_string = GetCwdString()
	let b:sessiondir = $HOME."/.nvim/sessions/" . a:cwd_string
	let b:sessionfile = b:sessiondir . '_session.vim'
	exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
	let a:cwd_string = GetCwdString()
	let b:sessiondir = $HOME."/.nvim/sessions/" . a:cwd_string
	let b:sessionfile = b:sessiondir . "_session.vim"
	if (filereadable(b:sessionfile))
		exe "mksession! " . b:sessionfile
		echo "updating session"
	endif
endfunction

" Loads a session if it exists
function! LoadSession()
	let a:cwd_string = GetCwdString()
	let b:sessiondir = $HOME."/.nvim/sessions/" . a:cwd_string
	let b:sessionfile = b:sessiondir . "_session.vim"
	if (filereadable(b:sessionfile))
		exe 'source ' b:sessionfile
	else
		echo "No session loaded."
	endif
endfunction

au VimEnter * nested :call LoadSession()
au VimLeave * :call UpdateSession()





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that
" vim
" keeps timing you out before you can complete them, try changing your
" timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

	""""""""""""" Standard cscope/vim boilerplate

	" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag

	" check cscope for definition of a symbol before checking ctags: set to 1
	" if you want the reverse search order.
	set csto=0

	" add any cscope database in current directory
	if filereadable("cscope.out")
		cs add cscope.out  
		" else add the database pointed to by environment variable 
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif

	" show msg when any other cscope db added
	set cscopeverbose  
	"

	""""""""""""" My cscope/vim key mappings

	" The following maps all invoke one of the following cscope search types:
	"
	"   's'   symbol: find all references to the token under cursor
	"   'g'   global: find global definition(s) of the token under cursor
	"   'c'   calls:  find all calls to the function name under cursor
	"   't'   text:   find all instances of the text under cursor
	"   'e'   egrep:  egrep search for the word under cursor
	"   'f'   file:   open the filename under cursor
	"   'i'   includes: find files that include the filename under cursor
	"   'd'   called: find functions that function under cursor calls
	"
	" Below are three sets of the maps: one set that just jumps to your
	" search result, one that splits the existing vim window horizontally and
	" diplays your search result in the new window, and one that does the same
	" thing, but does a vertical split instead (vim 6 only).
	"
	" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
	" unlikely that you need their default mappings (CTRL-\'s default use is
	" as part of CTRL-\ CTRL-N typemap, which basically just does the same
	" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
	" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
	" of these maps to use other keys.  One likely candidate is 'CTRL-_'
	" (which also maps to CTRL-/, which is easier to type).  By default it is
	" used to switch between Hebrew and English keyboard mode.
	"
	" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
	" that searches over '#include <time.h>" return only references to
	" 'time.h', and not 'sys/time.h', etc.  (by default cscope will return all
	" files that contain 'time.h' as part of their name).  

	" To do the first type of search, hit 'CTRL-\', followed by one of the
	" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
	" search will be displayed in the current window.  You can use CTRL-T to
	" go back to where you were before the search.  
	"

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


	" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
	" makes the vim window split horizontally, with search result displayed in
	" the new window.
	"
	" (Note: earlier versions of vim may not have the :scs command, but it
	" can be simulated roughly via:
	" nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	


	nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
	nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


	" Hitting CTRL-space *twice* before the search type does a vertical 
	" split instead of a horizontal one (vim 6 and up only)
	"
	" (Note: you may wish to put a 'set splitright' in your .vimrc
	" if you prefer the new window on the right instead of the left
	"
	nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
	nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

	""""""""""""" key map timeouts
	"
	" By default Vim will only wait 1 second for each keystroke in a mapping.
	" You may find that too short with the above typemaps.  If so, you should
	" either turn off mapping timeouts via 'notimeout'.
	"
	"set notimeout 
	"
	" Or, you can keep timeouts, by uncommenting the timeoutlen line below,
	" with your own personal favorite value (in milliseconds):
	"
	"set timeoutlen=4000
	"
	" Either way, since mapping timeout settings by default also set the
	" timeouts for multicharacter 'keys codes' (like <F1>), you should also
	" set ttimeout and ttimeoutlen: otherwise, you will experience strange
	" delays as vim waits for a keystroke after you hit ESC (it will be
	" waiting to see if the ESC is actually part of a key code like <F1>).
	"
	"set ttimeout 
	"
	" personally, I find a tenth of a second to work well for key code
	" timeouts.  If you experience problems and have a slow terminal or network
	" connection, set it higher.  If you don't set ttimeoutlen, the value for
	" timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
	"
	"set ttimeoutlen=100

endif

















"}}}
" Appearance {{{ 
syntax enable "enable syntax processing


set fillchars+=vert:│
"set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
let g:hybrid_use_Xresources = 1
set background=dark
colorscheme hm
set colorcolumn=81										" a ruler to mark off the 80th column

highlight SignifySignAdd    cterm=bold ctermbg=234  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=234  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=234  ctermfg=3

let g:signify_sign_change            = '~'
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_right_sep=''
let g:airline_left_sep=''
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
set laststatus=2 " for air line so the status bar at the bottom always displays
" }}}
" Vim LaTeX {{{
let g:tex_flavor='latex'		" use latex package with .tex files
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_dvi = 'latex "%" --interaction=nonstopmode $*'
" }}}

" vim:foldmethod=marker:foldlevel=0
