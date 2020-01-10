let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'majutsushi/tagbar'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'Yggdroot/indentLine'
Plug 'wellle/targets.vim'
Plug 'bfrg/vim-cpp-modern'
call plug#end()
packadd vimball

set bg=light
set go=a
set mouse=
set nohlsearch
nnoremap <F7> :set invhlsearch<CR>
set clipboard=unnamedplus
set updatetime=300
set undofile
nmap <F8> :TagbarToggle<CR>
let g:indentLine_enabled = 0
nmap <F11> :IndentLinesToggle<CR>
nmap <F12> :so /tmp/vim_script.vim<CR>

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" ctags
  let g:ctags_statusline=1
  nnoremap <A-]> :vsp<CR> <C-]>
  autocmd BufWritePost ~/bmad_dist/tao/python/* !ctags -R .
  autocmd BufWritePost ~/Dropbox/TeX/*.cpp !ctags -R .
  autocmd BufWritePost ~/Documents*.cpp !ctags -R .
  autocmd BufWritePost ~/Documents/cl/code/*c !ctags -R .

" Goyo plugin makes text more readable when writing prose:
"	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" python syntax check
  autocmd BufWritePost *.py !python -m py_compile % 2> >(tee >(mark_maker 2>/dev/null) >&2)

" Colors
  hi Search ctermfg = 0
  hi QuickFixLine ctermfg = 0
  hi QuickFixLine ctermbg = 11
" Toggle color column
  function CCon()
    set cc=80
    nnoremap <F10> :call CCoff()<CR>
  endfunction

  function CCoff()
    set cc=
    nnoremap <F10> :call CCon()<CR>
  endfunction

  nnoremap <F10> :call CCon()<CR>

" Check file in shellcheck:
	"map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Fortran syntax settings
  let fortran_free_source=1
  let fortran_more_precise=1
  let fortran_do_enddo=1

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts


" Settings for tao development
  au BufEnter tao.init set filetype=fortran
  au BufEnter *.bmad set filetype=fortran
  function Pydoc_Man()
    " Generate a manpage with pydoc_man_gen
    !pydoc_man_gen <cword>
    " Open the manpage (placed at /tmp/pydoc_man_page
    Man /tmp/pydoc_man_page
  endfunction
  autocmd BufEnter ~/bmad_dist/tao/python/* setlocal tabstop=4 expandtab softtabstop=4 shiftwidth=4
  autocmd BufEnter ~/bmad_dist/tao/python/* nnoremap K :call Pydoc_Man()<CR><CR>
  autocmd BufEnter ~/bmad_dist/tao/python/pytao/gui/doc/gui.tex map <leader>c :w! \| !compiler tao.tex<CR>
	autocmd VimLeave ~/bmad_dist/tao/python/pytao/gui/doc/gui.tex !texclear tao.tex
  " Syntax highlighting for bmad/tao config files
  autocmd BufNewFile,BufRead tao.init set filetype=fortran
  autocmd BufNewFile,BufRead *.bmad set filetype=fortran

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

" Set auto indent correctly
	autocmd FileType tex setlocal noautoindent nocindent nosmartindent indentexpr=
	set tabstop=2
	set expandtab
	set softtabstop=2
	set shiftwidth=2
	filetype indent on

" Set automatic scrolling
  set scrolloff=9999

" Word wrap
  set linebreak
  set breakindent

" remap :W to :w
  command W w
  command Q q

autocmd BufEnter ~/Dropbox/TeX/PHYS-4410/lab1/* map <leader>c :w! \| !make<CR>
autocmd BufEnter ~/Dropbox/TeX/PHYS-4410/lab2/* map <leader>c :w! \| !make<CR>
autocmd BufEnter ~/Dropbox/TeX/AEP-4380/hw/* map <leader>c :w! \| !make<CR>

" Deal with tab completing a file where multiple files with the same name but different endinds exist
" e.g. mod.cpp + mod.hpp + mod.o -> mod tab completes to mod.
" For c/c++, want to open the c/cpp file, and the header if it exists
" For latex, just want to open the tex

function GoodTabComplete()
  let l:basename = expand('%')
  " case 1: cpp + o ( + h/hpp)
  if filereadable(l:basename . 'cpp')
    exe 'edit ' . l:basename . 'cpp'
    set filetype=cpp
    " Check for header
    if filereadable(l:basename . 'hpp')
      exe 'vsp ' . l:basename . 'hpp'
      set filetype=cpp
    elseif filereadable(l:basename . 'h')
      exe 'vsp ' . l:basename . 'h'
      set filetype=cpp
    endif
  " Case 2: c + o ( + h )
  elseif filereadable(l:basename . 'c')
    exe 'edit ' . l:basename . 'c'
    set filetype=c
    " Check for header
    if filereadable(l:basename . 'h')
      exe 'vsp ' . l:basename . 'h'
      set filetype=c
    endif
  " Case 3: tex
  elseif filereadable(l:basename . 'tex')
    exe 'edit ' . l:basename . 'tex'
    set filetype=tex
  endif
endfunction

autocmd BufEnter *. call GoodTabComplete()

"""LATEX
" General
autocmd FileType tex inoremap ,en \begin{enumerate}<Enter>\item<Enter><Enter><Enter>\end{enumerate}<Enter><++><Esc>3ki
autocmd FileType tex inoremap ,it \begin{itemize}<Enter>\item<Enter><Enter><Enter>\end{itemize}<Enter><++><Esc>3ki
autocmd FileType tex inoremap ,pf \begin{proof}<Enter><Enter>\end{proof}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ,le \begin{lemma}{}<Enter><++><Enter>\end{lemma}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap ,vb \begin{verbatim}<Enter><Enter><Enter>\end{verbatim}<Enter><++><Esc>3ki
autocmd FileType tex inoremap ,pr \begin{problem}{}<Enter><++><Enter>\end{problem}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap ,ex \begin{exercise}{}<Enter><++><Enter>\end{exercise}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap ,sec \section*{}<Enter><++><Esc>k$i
autocmd FileType tex inoremap ,ssec \subsection*{}<Enter><++><Esc>k$i
autocmd FileType tex inoremap ,sssec \subsubsection*{}<Enter><++><Esc>k$i
" Math mode
autocmd FileType tex inoremap ,al \begin{align*}<Enter><Enter>\end{align*}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ,nal \begin{align}<Enter><Enter>\end{align}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ,ar \begin{array}{}<Enter><++><Enter>\end{array}<++><Esc>2k$i
autocmd FileType tex inoremap ,dc \begin{dcases*}<Enter><Enter>\end{dcases*}<++><Esc>ki
autocmd FileType tex inoremap ,ct \begin{figure}[h]<Enter>\begin{circuitikz} \draw <Enter><Enter>;<Enter>\end{circuitikz}<Enter>\centering\caption{<++>}<Enter>\end{figure}<Esc>5ki
" Figures
autocmd FileType tex inoremap ,fi \begin{figure}<Enter>\centering<Enter>\includegraphics[]{<++>}<Enter>\caption{<++><Enter>\end{figure}<Enter><++><Esc>3kf[a
autocmd FileType tex inoremap ,mp \begin{minipage}{}<Enter><++><Enter>\end{minipage}<Enter><++><Esc>3k$i
" Plot figure
autocmd FileType tex inoremap ,fp <Esc>:read ~/.config/nvim/TeX_snippets/plot.tex<CR>
autocmd FileType tex inoremap ,gp \addplot gnuplot [raw gnuplot, mark=none, black, thick]{<Enter><Enter>};<Esc>ki
autocmd FileType tex nnoremap <F12> :Man /home/john/.config/nvim/TeX_snippets/pgfplots_ref.txt<CR>
" Table
autocmd FileType tex inoremap ,tab <Esc>:read ~/.config/nvim/TeX_snippets/table.tex<CR>
" Code
autocmd FileType tex inoremap ,cpp \begin{lstlisting}<Enter><Enter>\end{lstlisting}<Enter><++><Esc>2ki
" Beamer
autocmd FileType tex inoremap ,bf \begin{frame}<Enter>\frametitle{}<Enter><++><Enter>\end{frame}<Enter><++><Esc>3k$i
autocmd FileType tex inoremap ,bc \begin{columns}<Enter>\column{}<Enter><++><Enter><Enter>\column{<++>}<Enter><++><Enter><Enter>\end{columns}<Enter><++><Esc>7k$i
" Swap left and right hand sides in align
autocmd FileType tex nnoremap ,swa 0"ldt&f=w"rd$"lp0"rP:s/\\\\//<Enter>



""".bib
	autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
