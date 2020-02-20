"****************全局设置*********************"
"取消VI兼容，避免以前版本的一些bug和局限
set nocompatible
"关闭vi模式
set nocp
"去掉输入错误的提示声音
set noeb
"UNIX 和微软视窗支持
set sessionoptions+=unix,slash

"***************语言与编码设置***************"
"用于菜单翻译的语言
set langmenu=zh_CN.UTF-8
"vim显示使用的编码方式
set encoding=utf-8
"vim编辑文件使用的编码方式
set fileencodings=ucs-bom,utf-8,chinese,gbk,gb2312

"显示中文帮助
if version>=700
	set helplang=cn,en
endif

"打开文件类型检测功能
filetype plugin indent on

"取消自动备份及产生swp文件
set nobackup
set nowb
set noswapfile

"显示行号, 或set number
set nu

"与windows共享剪贴板
set clipboard+=unnamed
"使用鼠标
set mouse=a
"允许区域选择
set selection=exclusive
set selectmode=mouse,key

"有 Vim 之外的改动时自动重读文件
set autoread
"自动保存
set autowrite
"在处理未保存或只读文件的时候，弹出确认
set confirm

"在搜索的时候忽略大小写
set ignorecase
"高亮被搜索的句子
set hlsearch
"在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

"打开语法高亮
if !exists("g:syntax_on")
	syntax enable
endif

"命令行命令补全增强
set wildmenu

"*****************theme setting*****************
"选择主题
"colorscheme molokai
"开启256颜色支持
set t_Co=256 
"选择主题色调 dark和light（暗色调和亮色调）
set background=dark

"使用标尺
set ruler
"光标移动时同时在其它窗口移动
set cursorbind
"进入插入模式,高亮光标所在屏幕行(cursorline)
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul
"进入插入模式,高亮光标所在屏幕列(cursorcolumn)
autocmd InsertLeave * se nocuc
autocmd InsertEnter * se cuc

"在行和段开始处使用制表符
set smarttab
"制表符为4
set tabstop=4
"统一缩进为4
set softtabstop=4
set shiftwidth=4
"缩进列数对齐到 shiftwidth 的整数倍
set shiftround
" 不要用空格代替制表符
set noexpandtab

"在一行开头按退格键如何处理
set backspace=indent,eol,start

"历史命令保存行数
set history=100

"设置命令行高度为2
set cmdheight=2
"启动显示状态行(1),总是显示状态行(2)
set laststatus=2

"整词换行
set linebreak
"通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

"在一行开头按退格键如何处理
set backspace=eol,start,indent
"关闭行的回绕
set nowrap
"向后滚动n个字符
set sidescroll=10
"如果 'wrap' 关闭，而行在屏幕右边界之后还要继续时，最后一列显示的字符。
set listchars+=precedes:<,extends:>

"插入括号时短暂跳转到匹配的括号
set showmatch
"状态栏显示当前执行的命令
set showcmd
"命令行显示vim当前模式
set showmode

"分割窗口时新窗口在当前窗口之下
set splitbelow
"新窗口在当前窗口之右
set splitright

"自动对齐
"set autoindent
"智能自动缩进
"set smartindent
"c语言风格缩进,开启cindent上边两个失效
set cindent

"设置C/C++语言的具体缩进方式
set cinoptions=>1s,e0,n-2,f0,{0,}0,:1s,=s,b0,ps,c4,C4,(03s,t0

"查找宏定义所使用的模式
set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

"*******************智能补全"*******************"
"C语言补全需要ctag生成的标签文件
"set tags+=/usr/tags
"打开文件类型检测,上边已经开启，此选项需要尽可能早开启
"filetype plugin indent on

" mapping
"如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车
inoremap <expr><CR> pumvisible()?"\<C-Y>":"\<CR>"
"如果下拉菜单弹出，CTRL-J映射为在下拉菜单中向下翻页。否则映射为CTRL-X CTRL-O
inoremap <expr><C-J> pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
"如果下拉菜单弹出，CTRL-K映射为在下拉菜单中向上翻页，否则仍映射为CTRL-K
inoremap <expr><C-K> pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U
inoremap <expr><C-U> pumvisible()?"\<C-E>":"\<C-U>"

"控制关键字补全在使用 CTRL-P 或 CTRL-N 时如何工作，也用于整行的补全  i_CTRL-X_CTRL-L 。
set complete=.,w,b,u,t,i,U,d
"提供下拉菜单
set completeopt=longest,menu,menuone

"设置特定字符配对
au FileType c,cpp set mps+==:;,(:),{:},[:],<:>,.:;
"使用matchit插件
packadd! matchit

"""""""""""""""""""""""""""""
" 允许折叠
set foldenable
"打开文件时默认不折叠
set nofen
"按照缩进折叠
set foldmethod=indent
"光标处打开折叠，离开重新折叠
"set foldclose=all
"自动打开匹配的内容折叠
"set foldopen=all

"*****************新文件标题******************
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.hpp,*.sh,Makefile,*.mk exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#########################################################################")
		call append(line("."), "\# File Name: ".expand("%"))
		call append(line(".")+1, "\# Author:")
		call append(line(".")+2, "\# System:")
		call append(line(".")+3, "\# created Time: ".strftime("%c"))
		call append(line(".")+4, "\#########################################################################")
		call append(line(".")+5, "\#!/bin/bash")
		call append(line(".")+6, "")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."), "    > File Name: ".expand("%"))
		call append(line(".")+1, "    > Author:")
		call append(line(".")+2, "    > System:")
		call append(line(".")+3, "    > created Time: ".strftime("%c"))
		call append(line(".")+4, " ************************************************************************/")
		call append(line(".")+5, "")
	endif

	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	elseif expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+7, "#define _".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+8, "")
		call append(line(".")+9, "")
		call append(line(".")+10, "#endif //".toupper(expand("%:t:r"))."_H_")
	elseif expand("%:e") == 'hpp'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+7, "#define _".toupper(expand("%:t:r"))."_H_")
		call append(line(".")+8, "#ifdef __cplusplus")
		call append(line(".")+9, "extern \"C\"")
		call append(line(".")+10, "{")
		call append(line(".")+11, "#endif")
		call append(line(".")+12, "")
		call append(line(".")+13, "")
		call append(line(".")+14, "#ifdef __cplusplus")
		call append(line(".")+15, "}")
		call append(line(".")+16, "#endif")
		call append(line(".")+17, "#endif //".toupper(expand("%:t:r"))."_H_")
	elseif &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
endfunc

"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G

"*************** 符号自动补全 ********************
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap ) <c-r>=ClosePair(')')<cr>
inoremap ] <c-r>=ClosePair(']')<cr>
"遇到}就换行然后匹配
"inoremap } <c-r>=CloseBracket()<cr>
inoremap } <c-r>=ClosePair('}')<cr>
inoremap " <c-r>=QuoteDelim('"')<cr>
inoremap ' <c-r>=QuoteDelim("'")<cr>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<cr>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		return a:char
	elseif line[col - 1] == a:char
		return "\<Right>"
	else
		return a:char.a:char."\<Esc>i"
	endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

"调整格式
map <F12> gg=G
"F11去空行  
"nnoremap <F11> :g/^\s*$/d<cr> 
"F10映射为插入函数头序列
map <F10> <Esc>0O/*<cr>@dEsc:<cr>@param:<cr>@return:<cr>*/<Esc>kkk$


map <F7> :call CompileRunGcc()<cr>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc -Wall % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ -Wall % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<cr>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc

