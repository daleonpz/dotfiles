" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just 
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
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
set scrolloff=10    " Always have at least 10 lines from bottom
" Configure how certain whitespace characters are displayed: tabs as »»,
" trailing spaces as ·, and non-breaking spaces as ~
execute "set listchars=tab:\u00bb\u00bb,trail:\u00b7,nbsp:~"
set list

set ruler " Enable the ruler, which shows the cursor position
" Customize the ruler format to display the date and time, line number, column
" number, and percentage through the file
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set formatoptions-=r formatoptions-=o

let mapleader=" "

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
noremap <F7> :%!xxd<CR> 
" Switch back 
noremap <leader><F7> :%!xxd -r<CR>

" save code blocks
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Indent the whole file
noremap <F6> mzgg=G`z

" Indent block 
noremap <F5> =i{

" Move selected lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor position when joining lines
nnoremap J mzJ`z

" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep search results centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Search and replace the word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Toggle paste mode on and off using the F9 key; paste mode disables
" auto-indenting and other automatic formatting, making it easier to paste
" code or text from an external source
set pastetoggle=<F9>

" set statusline+=%l/%L\ (%p%%)\ %F
" set statusline=%F
set statusline=%F\ %55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

source ~/.vim/autoload/cscope_maps.vim

" Function to search using ag within a specified path
" AgIn: Start ag in the specified directory
"
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

" Automatically change the current directory
set autochdir

""""""""""""""""""""""""""""""""
"   SYNTASTIC: LINT MANAGER    "
""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

noremap <F2> :SyntasticToggleMode<CR>
noremap <F3> :SyntasticCheck<CR>

let g:syntastic_c_checkers=['make','cppcheck']
let g:syntastic_sh_checkers=['shellcheck']
let g:syntastic_cmake_checkers=['cmakelint']
let g:syntastic_python_checkers=['mypy']
let g:syntastic_python_mypy_args=['--ignore-missing-imports', '--no-site-packages']
" let g:syntastic_c_cppcheck_args=['--enable=all']

""""""""""""""""""""""""""""""""
" TAGBAR PLUGIN
""""""""""""""""""""""""""""""""
" Toggle Tagbar
nmap <leader>t :TagbarToggle<CR>
" Ensure ctags is installed for better compatibility
let g:tagbar_ctags_bin='ctags'
let g:tagbar_width=40

" Enable Tagbar to appear on the left side
let g:tagbar_left=1

" Reduce updatetime to make CursorHold more responsive
set updatetime=50

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

set background=dark
set clipboard=unnamedplus
set clipboard+=unnamed

set tags=./tags,tags;/
" tags=./tags,./TAGS,tags,TAGS
" set cscopeprg=cscope -d
let g:copilot_node_command = "~/.nvm/versions/node/v20.15.0/bin/node"

"""""""""""""""""""""""""""""""""""
" PLUG: Plugin Manager            "
"""""""""""""""""""""""""""""""""""
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'
Plug 'github/copilot.vim'
call plug#end()
