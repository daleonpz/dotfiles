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
" Enable syntax highlighthing
syntax enable
" Enable filetype detection and plugins
filetype plugin on
" set relative number line
set rnu
" show file name 
set laststatus=2
" sets the cursor shape to a 100% sized vertical bar for insert mode 
set guicursor+=i:ver100-iCursor
" show where the cursor is
set cursorcolumn
set cursorline
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
" Configure how certain whitespace characters are displayed: tabs as »»,
" trailing spaces as ·, and non-breaking spaces as ~
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
set ruler " Enable the ruler, which shows the cursor position
" Customize the ruler format to display the date and time, line number, column
" number, and percentage through the file
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
    autocmd FileType markdown command DeutschNotes execute ":-1read $HOME/.vim/markdown/deutschNotes.skeleton"
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
" set smartcase

" repmap numpad to keyboard
inoremap <silent> <C-l> <kEnter>

augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter *.patch, *.ref, *.diff syntax enable
augroup END

" add comments
autocmd FileType c,cpp,cs,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab,yml,yaml,cmake       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType ada              let b:comment_leader = '-- '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
noremap <A-Left>  :-tabmove<cr>
noremap <A-Right> :+tabmove<cr>

" Switch to hex-editor`
noremap <S-F7> :%!xxd<CR> 
" Switch back 
noremap <F7> :%!xxd -r<CR>

" save code blocks
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Indent the whole file
noremap <F6> mzgg=G`z

" Indent block 
noremap <F5> =i{

" Toggle paste mode on and off using the F9 key; paste mode disables
" auto-indenting and other automatic formatting, making it easier to paste
" code or text from an external source
set pastetoggle=<F9>

" show Status line + linenumber and percentage (10/100) 10%
set statusline+=%l/%L\ (%p%%)\ %F

" source CSCOPE settings for vim 
source ~/.vim/autoload/cscope_maps.vim

" AgIn: Start ag in the specified directory
" e.g.
"   :AgIn .. foo
function! s:ag_in(bang, ...)
  let start_dir=expand(a:1)

  if !isdirectory(start_dir)
    throw 'not a valid directory: ' .. start_dir
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': start_dir}, 'up:50%:hidden', '?'), a:bang)

endfunction

command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)
""""""""""""""""""""""""""""""""
"    MAKE      "
""""""""""""""""""""""""""""""""
autocmd FileType make setlocal noexpandtab
" nnoremap <silent> ,make :set makeprg=gcc\ -Wall\ -W\ -g\ %:t<CR> \| :make!<CR> \| :set makeprg=make<CR> \|:clist<CR>
command! MakeGcc !gcc -Wall -W -g %
command! MakeTags !ctags -R .
command! Makepdf !pandoc -o %.pdf % && zathura %.pdf
set autochdir

" execute pathogen#infect()

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

""""""""""""""""""""""""""""""""
"   SYNTASTIC: LINT MANAGER    "
""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable SPLINT
noremap <S-F3> :let g:syntastic_c_checkers=['make','splint','cppcheck']<CR>:w<CR>
" Switch back 
noremap <F3> :let g:syntastic_c_checkers=['make','cppcheck']<CR>:w<CR>
noremap <F2> :SyntasticToggleMode<CR>

let g:syntastic_c_checkers=['make','cppcheck']
let g:syntastic_sh_checkers=['shellcheck']
let g:syntastic_cmake_checkers=['cmakelint']
let g:syntastic_python_checkers=['mypy']
let g:syntastic_python_mypy_args=['--ignore-missing-imports', '--no-site-packages']
" let g:syntastic_c_cppcheck_args=['--enable=all']

""""""""""""""""""""""""""""""""
" TAGBAR PLUGIN
""""""""""""""""""""""""""""""""
" Toggle Tagbar with F8
nmap <F8> :TagbarToggle<CR>
" Ensure ctags is installed for better compatibility
let g:tagbar_ctags_bin='ctags'
let g:tagbar_width=40
" Enable Tagbar to appear on the left side
let g:tagbar_left=1
" " Automatically open Tagbar when starting Vim or opening a file
" autocmd VimEnter * TagbarOpen
" autocmd BufReadPost * TagbarOpen

" Reduce updatetime to make CursorHold more responsive
set updatetime=1000
"
" " Auto-refresh Tagbar on CursorHold and CursorHoldI
autocmd CursorHold * silent! TagbarRefresh
autocmd CursorHoldI * silent! TagbarRefresh


" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" map <leader>r  :YcmCompleter GoToReferences<CR>
" 
" "Toggle YouCompleteMe on and off with F3
" function Toggle_ycm()
"     if g:ycm_show_diagnostics_ui == 0
"         let g:ycm_auto_trigger = 1
"         let g:ycm_show_diagnostics_ui = 1
"         :YcmRestartServer
"         :e
"         :echo "YCM on"
"     elseif g:ycm_show_diagnostics_ui == 1
"         let g:ycm_auto_trigger = 0
"         let g:ycm_show_diagnostics_ui = 0
"         :YcmRestartServer
"         :e
"         :echo "YCM off"
"     endif
" endfunction
" map <leader>y :call Toggle_ycm() <CR>
" 

" let g:ycm_python_interpreter_path = ''
" let g:ycm_python_sys_path = []
" let g:ycm_extra_conf_vim_data = [
"   \  'g:ycm_python_interpreter_path',
"   \  'g:ycm_python_sys_path'
"   \]
" let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
" 

let g:ag_working_path_mode="r"


" python with virtualenv support
set background=dark

set clipboard=unnamedplus
set clipboard+=unnamed


"""""""""""""""""""""""""""""""""""
" PLUG: Plugin Manager            "
"""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
"Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'
Plug 'github/copilot.vim'
" Plug 'rking/ag.vim'
" Plug 'epmatsw/ag.vim'
" Plug 'michal-h21/vim-zettel'
call plug#end()
