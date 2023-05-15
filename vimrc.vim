set autoindent "自动缩进
set cindent
set nowrap "不自动换行
set smartindent "智能对齐
set autowrite "自动保存
set iskeyword+=_,$,@,%,#,- "对应字符不因换行而被分割
set report=0 "cmd显示处理行
set showmatch "显示匹配的括号
set nofoldenable "禁用打开vim时自动折叠
set fdm=syntax "自动按语法折叠
set foldcolumn=0 "设置左侧折叠信息提示符宽度
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "取消自动注释
au FileType c,cc,cpp setlocal comments-=:// comments+=f:// "取消C文件换行自动注释
filetype indent on "自适应不同语言的智能缩进
set expandtab "将制表符扩展为空格
set tabstop=4 "设置编辑时制表符占用空格数
set shiftwidth=4 "设置格式化时制表符占用空格数
set softtabstop=4 "让vim 把连续数量的空格视为一个制表符
set smarttab "智能缩进
