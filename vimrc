"""""""""""""""""""" head: 17 """
" Map leader: C-e
"   Leader-r: for python, javascript,
"       python, shell, html, and markdown
"       run those thru interpreters or
"       by other necessary means
"   Leader-n: edit next file (:n)
"   Leader-p: edit previous file (:N)
"   Leader-x: save and quit (:wq)
"   Leader-q: quit without saving (:q!)
"   <C-w>tc: create a new tab
"   <C-w>tq: quit current tab
"   <C-w>tm: moves tab (fill in when called)
"   <C-w>": splits window horizontally
"   <C-w>/: splits window vertically
"   <C-s>: saves current file
"""""""""""""""""""""""""""""""""


set nocompatible

" Formatting
syntax on
syntax enable
set list
set listchars=tab:\|\ ,trail:\-,nbsp:%
set formatoptions+=otc
set matchpairs+=<:>
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nojoinspaces
set smartindent
set expandtab
set autoindent
set cindent
" The following two lines prevent indent from being removed when typing a hash
set cinkeys-=0#
set indentkeys-=0#
set nobreakindent

"" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent
set fdc=1

" Visuals
set showmatch
set matchtime=5
set relativenumber
set background=dark
set ruler
set conceallevel=2
set scrolloff=22 " stay around the middle of the screen while scrolling vertically
set sidescrolloff=5
set nowrap
set laststatus=2
set colorcolumn=80
highlight ColorColumn ctermbg=8

" Search and Replace
set ignorecase
set smartcase
set nogdefault
set incsearch

" Misc
set ttimeoutlen=100
set backupcopy=yes
set backupext=.vim.bak
set startofline
set belloff=all
set showcmd
set spelllang=en_us
set nospell

"" File Browsing (youtu.be/XA2WjJbmmoM)
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\$\+'
" :edit a folder to open in a file browser
" <CR>, v, or t to open in an h-split, v-split, or tab
" check |netrw-browse-maps| for more mappings

"" Finding Files (re: link above)
set path+=**
set wildmenu

"" set the backspace to delete normally
set backspace=indent,eol,start

" Keybinds

let mapleader = "\<C-e>"
noremap ; :

"" Change the redo keybind (`u' is already undo)
nnoremap <S-u> :redo<CR>

"" Folding
nnoremap <Leader>f za

"" Moving lines
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
" todo: visual mode

"" autocmd
if has('autocmd')
    "" set certain options for some text-based filetypes
    autocmd FileType markdown call TextSettings()
    autocmd FileType css call TextSettings()
    autocmd FileType text call TextSettings()
    autocmd FileType make call MakeSettings()

    "" set certain options for filetypes of programming languages
    autocmd FileType python call PythonSettings()
    autocmd FileType c* call CSettings()
    autocmd FileType cpp call CPPSettings()
    autocmd FileType vim call ProgrammingSettings()
    autocmd FileType java call JavaSettings()
    autocmd FileType javascript call JavaScriptSettings()
    autocmd FileType arduino call ArduinoSettings()

    "" source vimrc after editing it
    autocmd BufWritePost *vimrc autocmd! | source %

    "" Run Python scripts
    autocmd FileType python noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>
    autocmd FileType python inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/usr/bin/env python3' shellescape(@%, 1)<CR>

    "" Run Javascript scripts
    autocmd FileType javascript noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>
    autocmd FileType javascript inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/usr/bin/env node' shellescape(@%, 1)<CR>

    "" Run Shell scripts
    autocmd FileType sh noremap <buffer> <Leader>r :w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>
    autocmd FileType sh inoremap <buffer> <Leader>r <esc>:w<CR>:exec '!/bin/bash' shellescape(@%, 1)<CR>

    "" Show HTML Files
    autocmd FileType *html noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/env firefox file://' . expand("%:p:h") . '/' . shellescape(@%, 1)<CR>

    "" Show markdown files (uses Calibre's ebook-viewer)
    autocmd FileType markdown noremap <buffer> <Leader>r :w<CR>:exec '!/usr/bin/ebook-viewer --raise-window --detach' shellescape(@%, 1)<CR><CR>

    "" Run makefiles
    autocmd FileType make nnoremap <buffer> <Leader>r :w<CR>:exec '!make'<CR>
endif " has autocmd

"" Tabs
""" Moving tabs: gt for next, gT for previous
""" If in a split window, <C-w>T (capital T) opens current split in new tab
""" Open a new tab (tc for "tab create")
nnoremap <C-w>tc :tabnew<CR>
""" Close the current tab (tq for "tab quit")
nnoremap <C-w>tq :tabclose<CR>
""" Move a tab
nnoremap <C-w>tm :tabmove 

"" Windows
""" Keybinds to reflect my tmux.conf file
nnoremap <C-w>/ :vsplit<CR>
nnoremap <C-w>" :split<CR>

"" Saving and not exiting
imap <C-s> <ESC>:w<CR>a
nmap <C-s> :w<CR>

"" Saving and exiting
nnoremap <Leader>x :wq<CR>
inoremap <Leader>x <ESC>:wq<CR>

"" Exiting without saving
noremap <Leader>q :q!<CR>

"" Editing with multiple files
""" Next
nnoremap <Leader>n :n<CR>
inoremap <Leader>n <ESC>:w<CR>:n<CR>
""" Previous
nnoremap <Leader>p :N<CR>
inoremap <Leader>p <ESC>:w<CR>:N<CR>

"" xxd
"" interesting for reverse engineering but not really that useful
let g:ishex = 0 " off by default
function! Hex()
    let g:ishex = !g:ishex
    if g:ishex
        " this is where we convert the program into xxd
        call feedkeys(":w\<CR>:%!xxd\<CR>")
    else
        " convert back into text
        call feedkeys(":%!xxd -r\<CR>:w\<CR>")
    endif
endfunction
"map <F3> <ESC>:call Hex()<CR>

"" Make copying from tmux easier
function! ToggleMargin()
    set relativenumber!
    let nextfdc=!&fdc
    let &foldcolumn=nextfdc
    if nextfdc == 1
        set listchars=tab:\|\ ,trail:\-,nbsp:%
    else
        set listchars=tab:\ \ ,trail:\ ,nbsp:\ 
    endif
endfunction

nnoremap <Leader>c :call ToggleMargin()<CR>

"" Misc
nnoremap <Leader>h :set hlsearch!<CR>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"" Functions for different filetypes

function! TextSettings()
    " settings for markdown, css
    setlocal nocindent
    setlocal expandtab
    setlocal colorcolumn=80
endfunction

function! ProgrammingSettings()
    " settings for various programming languages
    setlocal softtabstop=4
endfunction

function! MakeSettings()
    setlocal noexpandtab
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

function! PythonSettings()
    call ProgrammingSettings()
    ab ifnamemain if __name__ == "__main__":
endfunction

function! CSettings()
    call ProgrammingSettings()
    ab cmainargs int main(int argv, char **argv)
    ab cmainvoid int main(void)
endfunction

function! CPPSettings()
    call CSettings()
endfunction

function! JavaSettings()
    call ProgrammingSettings()
    ab psvm public static void main(String[] args)
endfunction

function! JavaScriptSettings()
    call ProgrammingSettings()
endfunction

function! ArduinoSettings()
    call ProgrammingSettings()
endfunction
