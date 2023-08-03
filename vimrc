" ===========================================================================
" Author  : takumi_wake
" Note    : Vim Config File
" Version : 1.0.0
" Time    :
" Brief   :
" ===========================================================================


" =============================== auto cmd ==================================
" autocmd {{         增加自动执行配置命令

" auto chmod {       .py .sh 自动增加执行权限
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile>
"}
"

"}}

"============================= make =======================================
"make conf {        vim 内置命令make 配置修改
    set makeprg=gcc\ -Wall\ %<.c\ -o\ %<.o
"}

"============================= pathogen =======================================
"pathogen{          Vim用来管理插件的插件
    execute pathogen#infect()
"}


"================================ config =================================
syn on
"common conf {{             通用配置
    set nocompatible            " 设置不兼容原始vi模式
    set bs=2                    "在insert模式下用退格键删除
    set showmatch               "代码匹配
    set laststatus=2            "总是显示状态行
    set cursorline              "为光标所在行加下划线
    set number                  "显示行号

    "set encoding=utf-8
    "set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
    "set helplang=cn             "帮助系统设置为中文
    filetype on                 " 设置开启文件类型侦测
    filetype plugin on          " 设置加载对应文件类型的插件
    "set noeb                   " 关闭错误的提示
    syntax enable               " 开启语法高亮功能
    syntax on                   " 自动语法高亮
    set t_Co=256                " 开启256色支持
    set showcmd                 " select模式下显示选中的行数
    set ruler                   " 总是显示光标位置
    "set whichwrap+=<,>,h,l     " 设置光标键跨行
    set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
    set mouse=a                 " 设置使用鼠标模式
    set clipboard=unnamed       "把默认无名寄存器""和系统剪贴板关联上

if has("gui_macvim")
    set guifont=Menlo:h14
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码缩进和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent           " 设置自动缩进
set cindent              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0    " 设置C/C++语言的具体缩进方式
set smartindent          " 智能的选择对其方式
filetype indent on       " 自适应不同语言的智能缩进
set expandtab            " 将制表符扩展为空格
set tabstop=4            " 设置编辑时制表符占用空格数
set shiftwidth=4         " 设置格式化时制表符占用空格数
set softtabstop=4        " 设置4个空格为制表符
set smarttab             " 在行和段开始处使用制表符
"set nowrap               " 禁止折行
set wrap                 " 设置自动折行
set backspace=2          " 使用回车键正常处理indent,eol,start等
"set list listchars=tab:>-,trail:-,space:·    "制表符和空格以及行尾空格显示
"set nolist

" 自动去除尾行空格和tab
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
		"去掉每一尾行的空格和Tab
		silent! %s/\s\+$//
		"去掉文件最后无内容的行尾
		" silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
" autocmd BufWritePre * call RemoveTrailingWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch            " 检索时高亮显示匹配项
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存
set confirm             " 在处理未保存或只读文件的时候，弹出确认
" vim自动打开跳到上次的光标位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn                                                 "帮助系统设置为中文
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,gbk,gb2312   "cp936,ucs-bom,gb18030      "使用utf-8或gbk打开文件



"================================ map ===================================
let mapleader = ','
"设置生成ctag索引
    map <F7> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <CR>
    map <F8> :!cscope -bRq <CR>
"conf for tabs, 为标签页进行的配置，通过ctrl h/l切换窗口,用,t创建新标签等
    nnoremap <C-l> <C-w>l
    nnoremap <C-h> <C-w>h

" tab标签页面的创建和切换
nnoremap <leader>t : tabe<CR>
nnoremap <leader>tn : tabn<CR>
nnoremap <leader>tp : tabp<CR>

"调整分屏的纵向宽度和横向高度
nnoremap <leader>ww : vertical resize +10<CR>
nnoremap <leader>w  : vertical resize -10<CR>
nnoremap <leader>hh : resize +10<CR>
nnoremap <leader>h  : resize -10<CR>

"当其他地方修改文件后,刷新vim页面
nnoremap <leader>f  : e<CR>

" 列出vim所打开缓存的文件
nnoremap <leader>l : ls<CR>


" grep的快捷键使用,有可能影响其他插件
" map <F3> :silent noautocmd execute "grep -rin /" . expand("<cword>") . "/gj **/*" <Bar> cw<CR>
" map <F3> : silent noautocmd execute "grep! -rin " . shellescape(expand("<cWORD>")) . " ."<cr>:cw<cr>


"======================================复制粘贴快捷=======================
"说明：
"vim已经支持剪切板模式,不需要一下命令,暂时保留
"在insert模式下,使用鼠标中键粘贴
"
"支持在Visual模式下，通过Ctrl-y复制到系统剪切板
"vnoremap <C-y> "+y
"支持在normal模式下，通过Ctrl-p粘贴到系统剪贴板
"nnoremap <C-p> "+p
"支持在insert模式下粘贴
"innoremap <leader>p : <ESC>pa




"================================插件管理====================================
"
"=============================== vundle ==================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'qiaoshouxing/cscope_maps'
" Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'skywind3000/vim-preview'
Plugin 'scrooloose/nerdtree'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'nerdtree-ack'
Plugin 'tagbar'
Plugin 'L9'
" Plugin 'mileszs/ack.vim'
" Plugin 'OmniCppComplete'
Plugin 'autoload_cscope.vim'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
"
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" 用于自动异步生成tags
" Plugin 'ludovicchabant/vim-gutentags' "gutentags异步tags插件'
" Plugin 'skywind3000/gutentags_plus'

" rust-analyzer插件
Plugin 'rust-analyzer/rust-analyzer'


" 用于查看代码提交记录
Plugin 'zivyangll/git-blame.vim'


" 用模糊查找插件
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'


" 用于快读注释插件
Plugin 'preservim/nerdcommenter'

" 用于括号自动补全
" Insert or delete brackets, parens, quotes in pair.
Plugin 'jiangmiao/auto-pairs'

" 代码/注释/表格对齐
Plugin 'godlygeek/tabular'

" 用于轻量级代码补全脚本和字典
"Plugin 'skywind3000/vim-auto-popmenu'
"Plugin 'skywind3000/vim-dict'

" 用于文件的模糊查询
Plugin 'kien/ctrlp.vim'

" 用于Vim启动界面
Plugin 'mhinz/vim-startify'

" 自动补全插件
Plugin  'ycm-core/YouCompleteMe'

" tabnine补全插件,替换youcompleteme
" Plugin 'codota/tabnine-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"conf for plugins {{ 插件相关的配置


" ============ vim-gutentags 配置 ===================

" enable gtags module
" let g:gutentags_modules = ['ctags']

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" let g:gutentags_project_root = ['.takumi_project']
 
" 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = 'tags'
 
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif
 
" 配置 ctags 的参数 "
" let g:gutentags_ctags_extra_args = ['--fields=+niazs', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxi']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" change focus to quickfix window after search (optional).
" let g:gutentags_plus_switch = 1

" =================================================



" ============ git-blame 配置 ===================
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
" ==============================================


" ========= fzf/ripgrep 配置 =====================
"
" --no-ignore : according to .gitignore rule 
"
" 调用Rg进行搜索，包含隐藏文件
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --no-ignore-global --glob "!*tags" --glob "!cscope*" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)
  
"模糊查找文件
map <leader>p :Files<CR>
"模糊查找字符串
map <C-F> :Rg<CR>
" ================================================


"=========== nerdcommenter 配置 ================
"nerdcommenter插件快速注释
let g:NERDSpaceDelims            = 1      " 在注释符号后加一个空格
let g:NERDCompactSexyComs        = 1      " 紧凑排布多行注释
let g:NERDDefaultAlign           = 'left' " 逐行注释左对齐
let g:NERDAltDelims_java         = 1      " JAVA 语言使用默认的注释符号
let g:NERDCustomDelimiters       = {'c': {'left': '/*', 'right': '*/'}} " C 语言注释符号
let g:NERDCommentEmptyLines      = 1      " 允许空行注释
let g:NERDTrimTrailingWhitespace = 1      " 取消注释时删除行尾空格
let g:NERDToggleCheckAllLines    = 1      " 检查选中的行操作是否成功

" ==============================================


"=============== starity 配置 ===============
"设置书签
let g:startify_bookmarks            = [
            \ '~/Project/test.cpp',
            \]
"起始页显示的列表长度
let g:startify_files_number = 10
"自动加载session
let g:startify_session_autoload = 1
"过滤列表，支持正则表达式
let g:startify_skiplist = [
       \ '^/tmp',
       \ ]
"自定义Header和Footer
let g:startify_custom_header = [
            \ '                                                  ',
            \ '                  _               _           _   ',
            \ '           __   _(_)_ __ ___   __| |_   _ ___| |_ ',
            \ '           \ \ / / | `_ ` _ \ / _` | | | / __| __|',
            \ '            \ V /| | | | | | | (_| | |_| \__ \ |_ ',
            \ '             \_/ |_|_| |_| |_|\__,_|\__,_|___/\__|',
            \ '                                                  ',
            \ ]

" ========================================



" ============  YouCompleteMe  ============
" if we install vim-youcompleteme from APT
" sudo apt install vim-youcompleteme
" vam install vim-youcompleteme
" cp /usr/lib/ycmd/ycm_extra_conf.py  ~/.vim/
""""  # Add C/C++ headers dirs with -isystem or -I for each dir
""""  <code>gcc -print-prog-name=cc1</code> -v     # get C header search path
""""  <code>gcc -print-prog-name=cc1plus</code> -v # get C++ header search path

" ============= YCM For Rust ============
" rustup install nightly; rustup default nightly;
" rustup component add rust-src rustfmt rust-analysis rust-analyzer-preview;

let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['->', '.', '(', '[', '&']
let g:ycm_semantic_triggers={'c,cpp,python,rust,java,go,erlang,perl,cs,lua,javascript':['re!\w{1}']}
                                                    " Automatically invoke the syntax completion when 2 letters typed
set completeopt=menu,menuone                        " disable the function definition preview window
let g:ycm_add_preview_to_completeopt = 0            " disable auto preview to function definition
let g:ycm_server_log_level = 'info'
let g:ycm_show_diagnostics_ui = 0                   " disable 显示诊断信息,不再标注代码问题
let g:ycm_complete_in_comments=1                    " 补全功能在注释中同样有效
let g:ycm_seed_identifiers_with_syntax=1            " 语法关键字补全
let g:ycm_cache_omnifunc=0                          " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_goto_buffer_command='horizontal-split'    " horizontal split the window when 'goto' another location
let g:ycm_key_invoke_completion='<C-z>'             " Set the key binding which invoke syntax completion
let g:ycm_autoclose_preview_window_after_completion=1 " auto-close preview window after select a completion string
let g:ycm_autoclose_preview_window_after_insertion=1  " close preview window after leaving insert mode
" let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
" let g:ycm_rust_toolchain_root = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu'
" let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/'

"let g:ycm_filetype_whitelist = {
"          \ 'c':1,
"          \ 'cpp':1,
"          \ 'cmake':1,
"          \ 'go':1,
"          \ 'java':1,
"          \ 'python':1,
"          \ 'rust':1,
"          \ 'sh':1,
"          \ 'vim':1,
"          \ }

let g:ycm_language_server = [
	\   {
	\     'name': 'rust',
	\     'cmdline': [ 'rust_analyzer' ],
	\     'filetypes': [ 'rust' ],
	\     'project_root_files': [ 'Cargo.toml' ]
	\   }
	\ ]

nnoremap g] :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>

" 弹出的补全窗口颜色显示
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" =========================================


"状态栏的配置
"powerline{
    set guifont=PowerlineSymbols\ for\ Powerline
    set nocompatible
    set t_Co=256
    let g:Powerline_symbols = 'fancy'
"}


"NERDTree配置{
    let NERDTreeDirArrows = 0
    let NERDTreeShowBookMarks = 1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeKeepTreeInNewTab=1
    nnoremap <leader>e : NERDTree<CR>
"}

"
"Tagbar{
    nnoremap <leader>tl : Tagbar<CR>
"}
"OmniCppComplete {
    set nocp
    filetype plugin on
"}

"vim-go{
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
	\ }
"}



"==================ack================================
" nnoremap <leader>s :Ack<CR>
"



"==================vim-auto-popmenu===================
"vim-auto-popmenu
" enable this plugin for filetypes, '*' for all files.
"let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
"set cpt=.,k,w,b

" don't select the first item.
"set completeopt=menu,menuone,noselect

" suppress annoy messages.
"set shortmess+=c
"



" ==============ctrlp.vim=========================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
"


" ==============auto_pairs=========================
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'



"====================neocomplete===================
"neocomplete
" let g:neocomplete#enable_at_startup = 1
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"
"=========================================================



"autocomment {
function AddFileHead()
    call append(0, "/*******************************************************************************")
    call append(1, "           Copyright (C), 2014-2015,  Co., Ltd.")
    call append(2, " FileName    : ".expand("%:t"))
    call append(3, " Author      : alexander")
    call append(4, " Data        : ".strftime("%Y-%m-%d %H:%M"))
    call append(5, " Description :")
    echohl WarningMsg | echo "Successful in adding the copyrigh." | echohl None
    call append(6, "*******************************************************************************/")
    call append(7, "")
    call append(8, "#ifdef __cplusplus")
    call append(9, "extern \"C\" {")
    call append(10, "#endif")
    call append(11, "#ifdef __cplusplus")
    call append(12, "}")
    call append(13, "#endif")
endfunction

function AddFuncHead()
    let start = line(".")
    call append(start, "/*******************************************************************************")
    call append(start + 1, " Function name : ")
    call append(start + 2, " Input         : ")
    call append(start + 3, " Output        : ")
    call append(start + 4, " Return        : ")
    call append(start + 5, " Author        : alexander")
    call append(start + 6, " Data          : ".strftime("%Y-%m-%d"))
    call append(start + 7, " Description   : ")
    call append(start + 8, "*******************************************************************************/")
    echohl WarningMsg | echo "Successful in adding the comment" | echohl None
endfunction
map <F4> : call AddFileHead()<cr>
map <F5> : call AddFuncHead()<cr>
"}

"}}


