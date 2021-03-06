" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just " /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!


""""""""""""""""""""""""""""""""""""""""""
"  BASIC CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""
" work vim as vim and not as vi
set nocompatible
set autochdir
 
syntax enable
filetype plugin on

" set relative number line
set rnu

" show file name 
set laststatus=2

" sets the cursor shape to a 100% sized vertical bar for insert mode 
set guicursor+=i:ver100-iCursor

" show where the cursor is
set cursorcolumn

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

execute "set listchars=tab:\u00bb\u00bb,trail:\u00b7,nbsp:~"
set list
""""""""""""""""""""""""""""""""""""""""""
" FINDING FILES:
""""""""""""""""""""""""""""""""""""""""""
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set path+=$HOME/.vim/**

" Display all matching files when we tab complete
set wildmenu

""""""""""""""""""""""""""""""""
"    PLUGINS      "
""""""""""""""""""""""""""""""""
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)


""""""""""""""""""""""""""""""""""""""""""
"
"              SNIPPETS
"
""""""""""""""""""""""""""""""""""""""""""
" Read an empty HTML template and move cursor to title
"command Fnmd  execute ":-1read $HOME/.vim/.footnote.mdmail"

""""""""""""""""""""""""""""""""
"    MARKDOWN SETTINGS      "
""""""""""""""""""""""""""""""""
function Dictionary(lang)
    let b:base_path ="/home/dnl/.vim/dictionary/dict.".a:lang 
    if filereadable(b:base_path)
        execute "set dictionary=".b:base_path
    else
        echo "No existing language dictionary"
    endif
endfunction

augroup md_settings 
    set filetype=markdown
    autocmd FileType markdown command ZettelAddBook execute ":-1read $HOME/.vim/markdown/book.skeleton" 
    autocmd FileType markdown command ZettelAddWebsite execute ":-1read $HOME/.vim/markdown/website.skeleton" 
    autocmd FileType vim nnoremap <silent> <leader>zab :ZettelAddBook<CR>j:r! echo %<CR> kgJgJjh
    autocmd FileType vim nnoremap <silent> <leader>zaw :ZettelAddWebsite<CR>j:r! echo %<CR> kgJgJjh
    autocmd FileType markdown vmap ** xi**<Esc>pi**<Esc>
    autocmd FileType markdown vmap __ xi__<Esc>pi__<Esc> 
    autocmd FileType markdown set complete+=k
"     autocmd FileType markdown nnoremap ** :norm ea**<cr>:norm 2bi**<cr>
"     autocmd FileType markdown nnoremap __ :norm ea__<cr>:norm bi__<cr>
augroup END 


""""""""""""""""""""""""""""""""
"    VIM SETTINGS      
""""""""""""""""""""""""""""""""
augroup vim_settings 
    set filetype=vim 
    autocmd FileType vim nnoremap <silent> ,sec :-1read /home/dnl/.vim/vim/section_div.template<CR>j5li
augroup END 


""""""""""""""""""""""""""""""""
"    PYTHON SETTINGS      "
""""""""""""""""""""""""""""""""
augroup py_settings 
    set filetype=python
    autocmd!
    autocmd FileType python nnoremap <silent> ,sec :-1read $HOME/.vim/python/section_div.template<CR>j5li
augroup END 


""""""""""""""""""""""""""""""""
"    C SETTINGS      "
""""""""""""""""""""""""""""""""
augroup c_settings 
    set filetype=c
    autocmd!
    autocmd FileType c nnoremap <silent> ,sec :-1read $HOME/.vim/c/section_div.template<CR>j5li
    "autocmd FileType c command SecDiv execute ":-1read $HOME/.vim/c/section_div.template<CR>j5wi"
augroup END 


""""""""""""""""""""""""""""""""
"    CPP SETTINGS      "
""""""""""""""""""""""""""""""""
augroup cpp_settings 
    set filetype=cpp
    autocmd!
    autocmd FileType cpp nnoremap <silent> ,sec :-1read $HOME/.vim/c/section_div.template<CR>j5li
augroup END


""""""""""""""""""""""""""""""""
"    MISC      "
""""""""""""""""""""""""""""""""
" set keywordprg=trans\ -b
set keywordprg=trans\ -d 

" repmap numpad to keyboard
inoremap <silent> <C-l> <kEnter>

augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter *.patch, *.ref, *.diff syntax enable
augroup END

" add comments
autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType ada              let b:comment_leader = '-- '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Switch to hex-editor`
noremap <F8> :%!xxd<CR> 
" Switch back 
noremap <F7> :%!xxd -r<CR>

" save code blocks
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Indent the whole file
noremap <F6> mzgg=G`z

" Indent block 
noremap <F5> =i{

" Move around buffers
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>

""""""""""""""""""""""""""""""""
"    MAKE      "
""""""""""""""""""""""""""""""""
autocmd FileType make setlocal noexpandtab
" nnoremap <silent> ,make :set makeprg=gcc\ -Wall\ -W\ -g\ %:t<CR> \| :make!<CR> \| :set makeprg=make<CR> \|:clist<CR>
command! MakeGcc !gcc -Wall -W -g %

command! MakeTags !ctags -R .

command! Makepdf !pandoc -o %.pdf % && zathura %.pdf

""""""""""""""""""""""""""""""""
"    Zettelkasten "
""""""""""""""""""""""""""""""""
let g:zettelkasten = "/home/dnl/Documents/git/zettelkasten/_posts/"
" command! -nargs=1 NewZettel :execute ":e" zettelkasten . strftime("%Y-%m-%d-%H%M") . "-<args>.md"
command! -nargs=0 NewZettel :execute ":e" zettelkasten . strftime("%Y-%m-%d-%H%M%s").".md"
nnoremap <leader>zn :NewZettel<CR>
nnoremap <leader>zs :ZettelSearch<CR>
nnoremap <leader>zb :ZettelBackLinks<CR>

execute pathogen#infect()


" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Switch to hex-editor`
noremap <F3> :let g:syntastic_c_checkers=['make','splint','cppcheck']<CR>:w<CR>
" Switch back
noremap <F4> :let g:syntastic_c_checkers=['make','cppcheck']<CR>:w<CR>
noremap <F2> :SyntasticToggleMode<CR>

let g:syntastic_c_checkers=['make','cppcheck']
" let g:syntastic_c_cppcheck_args=['--enable=all']


call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'
call plug#end()
