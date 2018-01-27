" Vim settings and mappings

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" fold setting
set foldenable
set foldmethod=syntax
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" indent setting
set autoindent
set cindent
set smartindent
" tabs and spaces handling
set expandtab

if &filetype == "ruby"
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
else
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endif

" highlight cursor line and column
set cursorline
" set cursorcolumn
" hidden startup messages
set shortmess=atI
" auto read and write
set autowrite
" set autoread
" when deal with unsaved files ask what to do
set confirm
" no backup files
set nobackup
" other settings
set langmenu=zh_CN.UTF-8
set mouse=a
set whichwrap+=<,>,h,l,[,]
set background=dark
set encoding=utf-8

set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

" auto open or close NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" always show status bar
set laststatus=2

" incremental search
set incsearch
" highlighted search results
set hlsearch
" search ignore case
set noignorecase
" muting search highlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" syntax highlight on
syntax on

" show line numbers
set nu
" show relativenumber
set relativenumber

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like zsh
" (autocomplete menu)
set wildmenu
set wildmode=full

set viminfo+=!          " 保存全局变量
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" Gui Options
if has("gui_running")
    set guioptions-=m " Hide Menu
    set guioptions-=T " Hide Tool Menu
endif

let mapleader = ","

"""""""""""""""   onekey to complie or run
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc -Wall "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

func! CompileGpp()
    exec "w"
    let compilecmd="!g++ -Wall"
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    if search("boost/regex.hpp") != 0
        let complieflag .= " -Lboost-lib-path -lboost_regex "
    endif
    exec compilecmd." % ".compileflag
endfunc

func! CompileCode()
    exec "w"
    if g:filetypesuffix == "cpp"
        exec "call CompileGpp()"
    elseif g:filetypesuffix == "c"
        exec "call CompileGcc()"
    elseif g:filetypesuffix == "java"
        exec "!javac %"
    endif
endfunc

func! RunResult()
    exec "w"
    let RunCodeOptions = "!time "
    if search("mpi\.h") != 0
        exec "!mpirun -np 4 ./%<"
    elseif g:filetypesuffix == "cpp"
        exec RunCodeOptions."./%<"
    elseif g:filetypesuffix == "c"
        exec RunCodeOptions."./%<"
    elseif g:filetypesuffix == "rb"
        exec RunCodeOptions."ruby %"
    elseif g:filetypesuffix == "py"
        exec RunCodeOptions."python %"
    elseif g:filetypesuffix == "java"
        exec RunCodeOptions."java %<"
    endif
endfunc

map <F8> :call CompileCode()<CR>
imap <F8> <ESC>:call CompileCode()<CR>
vmap <F8> <ESC>:call CompileCode()<CR>

map <F9> :call RunResult()<CR>


set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" General
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'                " Better file browser
Plugin 'scrooloose/nerdcommenter'           " Code commenter
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'kien/ctrlp.vim'                     " Code and files fuzzy finder
Plugin 'vim-airline/vim-airline'            " Airline
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'Townk/vim-autoclose'                " Autoclose
Plugin 'michaeljsmith/vim-indent-object'    " Indent text object
Plugin 'vim-syntastic/syntastic'               " Code checker
Plugin 'tpope/vim-surround'                 " Quick surround char
Plugin 'tpope/vim-repeat'
Plugin 'Chiel92/vim-autoformat'             " Pre-written way to format code
Plugin 'Yggdroot/indentLine'                " IndentLine
Plugin 'mhinz/vim-startify'                 " start screen

" Colorscheme
Plugin 'altercation/vim-colors-solarized'
Plugin 'liuchengxu/space-vim-dark'

Plugin 'haya14busa/incsearch.vim'           " Search and highlight all
Plugin 'easymotion/vim-easymotion'          " Quickly move

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'endwise.vim'

Plugin 'ryanoasis/vim-devicons'             " GUI icons

" Html
" Plugin 'mattn/emmet-vim' 卡
" Plugin 'othree/html5.vim'
Plugin 'alvan/vim-closetag'

" python

call vundle#end()            " required
filetype plugin indent on    " required

" Plugin Confinguration

" IndentLine -------------------------------
let g:indentLine_char = '┊'

" Autoformat -------------------------------
noremap <F5> :Autoformat<CR>

" Tagbar -----------------------------------
let g:tagbar_ctags_bin = '/usr/bin/ctags'
let g:tagbar_width = 25
map <F4> :TagbarToggle<CR>
imap <F4> <ESC> :TagbarToggle<CR>

" Colorscheme ------------------------------
" colorscheme solarized
colorscheme space-vim-dark
hi Comment cterm=italic

" Airline ----------------------------------
" let g:airline_theme="papercolor"
" let g:airline_theme="badwolf"
let g:airline_theme = "onedark"
let g:airline_powerline_fonts = 1
"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" Ctrlp ------------------------------------
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = ':CtrlP'
let g:ctrlp_working_path_mode = '0'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Nerdtree ----------------------------------
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>

" Nerdtree Git Plugin
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹ ",
            \ "Staged"    : "✚ ",
            \ "Untracked" : "✭ ",
            \ "Renamed"   : "➜ ",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖ ",
            \ "Dirty"     : "✗ ",
            \ "Clean"     : "✔︎ ",
            \ 'Ignored'   : '☒ ',
            \ "Unknown"   : "?"
            \ }

" Nerd Font ---------------------------------
" set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Regular\ 14
set guifont=UbuntuMonoDerivativePowerline\ Nerd\ Font\ Regular\ 14

" Syntastic ---------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" let g:syntastic_cpp_include_dirs = ['/usr/include/c++/7.2.0']

" let g:syntastic_cpp_remove_include_errors = 1
" let g:syntastic_cpp_check_header = 1
" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = '-Wall -std=c++11 -stdlib=libstdc++'
" set error or warning signs
" let g:syntastic_cpp_cpplint_exec = "cpplint"
" let g:syntastic_cpp_checkers = ['cpplint']
autocmd BufNewFile,BufRead *.nasm set filetype=nasm
let g:syntastic_error_symbol = '✗ '
let g:syntastic_warning_symbol = '⚠ '
let g:syntastic_style_error_symbol = '✠ '
let g:syntastic_style_warning_symbol = '≈≈'

" whether to show balloons
" let g:syntastic_enable_balloons = 1



" YCM ---------------------------------------
let g:ycm_confirm_extra_conf = 0
let g:ycm_server_python_interpreter='/usr/bin/python2.7'
" let g:ycm_error_symbol = '>>'
" let g:ycm_warning_symbol = '>*'
" let g:ycm_always_populate_location_list = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_show_diagnostics_ui = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_cache_omnifunc = 0
" nnoremap <leader>u :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>
nnoremap <leader>i :YcmCompleter GoToInclude<CR>
nmap ycm :YcmDiags<CR>


" Vim-markdown ------------------------------
" Disabled automatically folding
let g:vim_markdown_folding_disabled=1
" Highlight YAML frontmatter
let g:vim_markdown_frontmatter=1
" Syntax Concealing
let g:vim_markdown_conceal = 0
" LeTeX math
let g:tex_conceal = ""
let g:vim_markdown_math=1

" Vim-instant-markdown -----------------
" If it takes your system too much, you can specify
" let g:instant_markdown_slow = 1
" if you don't want to manually control it
" you can open this setting
" and when you open this, you can manually trigger preview
" via the command :InstantMarkdownPreview
let g:instant_markdown_autostart = 1

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


map <Leader> <Plug>(easymotion-prefix)

" Closetag ---------------------------------

let g:closetag_filenames = '*html*'

" Emmet ------------------------------------
"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall
"let g:user_emmet_leader_key='<C-M>'

"""""               new file
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
func SetTitle()
    if &filetype == "sh"
        call setline(1,"#!/bin/zsh")
        call append(line("."), "")
    elseif &filetype == "python"
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    elseif &filetype == "ruby"
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    elseif &filetype == "markdown"
        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    elseif &filetype == "c"
        call setline(1,"/* ***********************************************************************")
        call append(line("."),"    > File Name: ".expand("%"))
        call append(line(".")+1,"    > Author: Key")
        call append(line(".")+2,"    > Mail: keyld777@gmail.com")
        call append(line(".")+3,"    > Created Time: ".strftime("%c"))
        call append(line(".")+4,"*********************************************************************** */")
        call append(line(".")+5, "#include <stdio.h>")
        call append(line(".")+6, "")
    elseif &filetype == "java"
        call setline(1,"/* ***********************************************************************")
        call append(line("."),"    > File Name: ".expand("%"))
        call append(line(".")+1,"    > Author: Key")
        call append(line(".")+2,"    > Mail: keyld777@gmail.com")
        call append(line(".")+3,"    > Created Time: ".strftime("%c"))
        call append(line(".")+4,"*********************************************************************** */")
        call append(line(".")+5,"public class ".expand("%:r"))
        call append(line(".")+6,"")
    elseif expand("%:e") == "cpp"
        call setline(1,"/* ***********************************************************************")
        call append(line("."),"    > File Name: ".expand("%"))
        call append(line(".")+1,"    > Author: Key")
        call append(line(".")+2,"    > Mail: keyld777@gmail.com")
        call append(line(".")+3,"    > Created Time: ".strftime("%c"))
        call append(line(".")+4,"*********************************************************************** */")
        call append(line(".")+5, "#include <bits/stdc++.h>")
        call append(line(".")+6, "")
        call append(line(".")+7, "#define each(i, n) for (int(i) = 0; (i) < (n); (i)++)")
        call append(line(".")+8, "#define reach(i, n) for (int(i) = n - 1; (i) >= 0; (i)--)")
        call append(line(".")+9, "#define range(i, st, en) for (int(i) = (st); (i) <= (en); (i)++)")
        call append(line(".")+10, "#define rrange(i, st, en) for (int(i) = (en); (i) >= (st); (i)--)")
        call append(line(".")+11, "#define fill(ary, num) memset((ary), (num), sizeof(ary))")
        call append(line(".")+12, "")
        call append(line(".")+13, "using namespace std;")
        call append(line(".")+14, "typedef long long ll;")
        call append(line(".")+15, "typedef pair<int,int> pii;")
        call append(line(".")+16, "")
    elseif expand("%:e") == "h"
        call setline(1,"/* ***********************************************************************")
        call append(line("."),"    > File Name: ".expand("%"))
        call append(line(".")+1,"    > Author: Key")
        call append(line(".")+2,"    > Mail: keyld777@gmail.com")
        call append(line(".")+3,"    > Created Time: ".strftime("%c"))
        call append(line(".")+4,"*********************************************************************** */")
        call append(line(".")+5, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+6, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#endif")
    endif
endfunc
autocmd BufNewFile * normal G
