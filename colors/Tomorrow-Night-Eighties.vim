" Tomorrow Night Eighties - Full Colour and 256 Colour
" http://chriskempson.com
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI Colours
let s:background = "16191C" "for gvim
" let s:background = "073642"   "base2 gvim problue-term 262626
" let s:background = "002b36" "base3 gvim deepproblue-term 1c1c1c 
let s:background2 = "262626"

let s:foreground = "C5C8C6"     "silver grey
let s:selection = "6B6865"
let s:selection2 = "252525"

let s:error = "FF0000"
let s:white = "FFFFFF"
let s:darkblue="1874CD"         "dark blue bg
let s:light_green = "82ECA5"    "Identifier light green
let s:cyan = "2DE3FE"           "include if endif

let s:tan = "CD853F"            "Peru color
let s:azure ="F0FFFF"           "light white+little blue
let s:black = "000000"
let s:chartreuse = "B9CA4A"     "yellow-green light string
let s:yellow = "FFCC66"         "int unsigned char
let s:red = "F2777A"            "macro quote -like orange color -Co256

let s:line = "23282D"
let s:palegoldenrod = "EEE8AA"  "light cream-color light-wood-color continue; begin end
let s:special ="75507B"         "purple bg
let s:dodgerblue = "1E90FF"     "light blue fg
let s:blue = "7AA6DA"           "function name
let s:blue2 = "729FCF"          "function name
let s:blue3 = "b0e0e6"          "function name
let s:condi = "dda0dd"          "if else for while
let s:orange = "F99157"         "pink-yellow light-red like punica
let s:purple = "CC99CC"
let s:window = "4D5057"
let s:base02 = "073642"


" Console 256 Colours
if !has("gui_running")
    " let s:background = "252525"
    let s:background = "262626"
    " let s:background = "1c1c1c"
    let s:window = "5e5e5e"
    let s:line = "3a3a3a"
    let s:selection = "585858"
end



hi clear
syntax reset

let g:colors_name = "Tomorrow-Night-Eighties"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
    " Returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " Returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " Returns the palette index for the given grey index
    fun <SID>grey_colour(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " Returns an approximate colour index for the given colour level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " Returns the actual colour level for the given colour index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " Returns the palette index for the given R/G/B colour indices
    fun <SID>rgb_colour(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " Returns the palette index to approximate the given R/G/B colour levels
    fun <SID>colour(r, g, b)
        " Get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " Get the closest colour
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " There are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " Use the grey
                return <SID>grey_colour(l:gx)
            else
                " Use the colour
                return <SID>rgb_colour(l:x, l:y, l:z)
            endif
        else
            " Only one possibility
            return <SID>rgb_colour(l:x, l:y, l:z)
        endif
    endfun

    " Returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>colour(l:r, l:g, l:b)
    endfun

    " Sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun

    "test -based on colorscheme /usr/share/vim/vim74/colors/desert.vim
    "so normal identifier in .v will be light_green
    "because there is not exist any verilog improved synatx addons so I get it indirectly
    "it's none affect C or C++ but verilog
    " Vim Automatically Highlighting vim编辑器全局颜色设定
    " call <SID>X("Normal", s:foreground, s:background, "") 
    " 注意normal的第二部分代表着整体环境的真-背景色
    " normal的第一部分代表着普通字符的颜色
    call <SID>X("Normal", s:white, s:background, "") 
    call <SID>X("Error", s:error, s:background, "") 
    call <SID>X("Search", s:black, s:light_green, "")
    "假如底色变成了base02
    " call <SID>X("Search", s:white, s:light_green, "")

    "vim脚本颜色设定
    call <SID>X("vimAutoEvent", s:red, "", "")
    call <SID>X("vimOption", s:orange, "", "")
    " call <SID>X("vimNumber", s:cyan,"","") 
    "vimError用一般的hi写法会有奇怪的错误-配色效果
    call <SID>X("vimError", s:error, s:background, "") 
    call <SID>X("vimCommand", s:light_green, "", "none")
    "括号匹配
    hi MatchParen ctermfg=0 ctermbg=12 guifg=Black guibg=#9999FF
    "ctrl+v alt+?
    hi SpecialKey term=reverse cterm=reverse ctermfg=240 ctermbg=116  

    hi ErrorMsg term=standout ctermfg=0 ctermbg=9 guifg=Black guibg=#FF7272

    hi CCTreeMarkers     ctermfg=221    guifg=#FFCC66 
    hi CCTreeSymbol      ctermfg=121     guifg=#82ECA5 

    hi SyntasticError     ctermfg=0   ctermbg=9 guifg=Black guibg=#FF7272
    hi SyntasticWarning   ctermfg=0   ctermbg=11 guifg=Black guibg=#FFDB72
    hi SyntasticStyleError ctermfg=0   ctermbg=12 guifg=Black guibg=#9999FF
    hi SyntasticWarning   ctermfg=0   ctermbg=13 guifg=Black guibg=#FFB3FF

    hi GitAdd   ctermfg=0   ctermbg=14 guifg=Black guibg=#8CCBEA
    hi GitRemove ctermfg=0 ctermbg=13 guifg=Black guibg=#FFB3FF

    hi NERDTreeDir    ctermfg=45 guifg=#2DE3FE
    hi NERDTreeFile   ctermfg=152 guifg=#B0E0E6


    " hi indentguidesodd  guibg=goldenrod3  ctermbg=3
    " hi indentguideseven guibg=dodgerblue4 ctermbg=4

    " 实现了奇偶色深不同的设定 如不需 可都选selection 或line
    " call <SID>X("indentguidesodd", "", s:selection, "")
    call <SID>X("indentguidesodd", "", s:line, "")
    call <SID>X("indentguideseven", "", s:line, "")

    hi tagbarkind guifg=cyan ctermfg=cyan
    hi tagbarsignature guifg=yellow ctermfg=yellow


    " call <SID>X("Keyword", s:blue3, "", "")
    " 这时行数条的颜色设置
    call <SID>X("LineNr", s:selection, "", "")
    "书签条  就是这个了 完美的解决了一致性显示问题 是marks所在的栏 警告也在此栏 
    call <SID>X("SignColumn", s:background2, s:line, "")
    " 虚拟模式选中 透明色
    call <SID>X("Visual", "", s:selection, "")
    "搜索结果高亮
    call <SID>X("NonText", s:blue3, "", "")
    " 窗口框架间分割区域配色 完善的方法 -本版改进配合Numix主题已经有Sublime风了
    " call <SID>X("VertSplit", s:foreground, s:window, "none")
    call <SID>X("VertSplit", s:background2, s:background2, "none")

    " call <SID>X("SpecialKey", s:selection, "", "")
    call <SID>X("StatusLine", s:window, s:yellow, "reverse")
    call <SID>X("TabLine", s:foreground, s:background, "reverse")
    call <SID>X("StatusLineNC", s:window, s:blue, "reverse")
    call <SID>X("Directory", s:blue, "", "")
    call <SID>X("ModeMsg", s:blue, "", "")
    call <SID>X("MoreMsg", s:chartreuse, "", "")
    call <SID>X("Question", s:chartreuse, "", "")
    call <SID>X("WarningMsg", s:light_green, "", "")
    call <SID>X("Folded", s:darkblue, s:background, "")
    call <SID>X("FoldColumn", "", s:background, "")
    if version >= 700
        call <SID>X("CursorLine", "", s:line, "none")
        call <SID>X("CursorColumn", "", s:line, "none")
        call <SID>X("PMenu", s:black, s:blue3, "none")
        call <SID>X("PMenuSel", s:darkblue, s:azure, "reverse")
    end
    if version >= 703
        call <SID>X("ColorColumn", "", s:line, "none")
    end


if !has("gui_running")
    call <SID>X("Comment", s:darkblue, "", "")              "终端vim无法同时显示正体与斜体
    " call <SID>X("Comment", s:darkblue, "", "italic")        "gvim可以显示斜体
else
    call <SID>X("Comment", s:darkblue, "", "italic")        "gvim可以显示斜体
end

    "Standard Highlighting vim给其他语法文件标准颜色接口设计
    call <SID>X("Todo", s:yellow, s:background, "")
    call <SID>X("Title", s:light_green, "", "")
    " call <SID>X("Comment", s:darkblue, "", "")               "这是注释 暗蓝色-背景色
    call <SID>X("String", s:chartreuse, "", "")             "字符串配色 接近-黄绿色
    call <SID>X("Constant", s:azure, "", "")                "常数 [] 亮白色-淡绿(看不出来)-前景
    call <SID>X("Special", s:tan, "", "")                   "tan 实际上接近 巧克力色 %p\n %s \0
    call <SID>X("Statement", s:palegoldenrod, "", "")       "break;continue; begin end 接近米色 且用粗体
    call <SID>X("Operator", s:orange, "", "none")           "();++,-= 操作符 橘红色
    call <SID>X("Include", s:cyan, "", "")                  "这是 #include 着色同#if 0 #endif
    call <SID>X("Define", s:cyan, "", "none")               "it's #define 定义宏专用
    call <SID>X("PreProc", s:cyan, "", "")                  "it's #if 0 #endif
    call <SID>X("Identifier", s:light_green, "", "none")    "这是普通的-自定义的 标识符
    call <SID>X("Function", s:blue3, "", "")                 "函数名配色 中度blue-中等亮度-前景色  刚刚好
    "call <SID>X("Function", s:yellow, "", "")                 "函数名配色 中度blue-中等亮度-前景色  刚刚好 */
    call <SID>X("Conditional", s:foreground, "", "")
    call <SID>X("Repeat", s:foreground, "", "")
    " call <SID>X("Ignore", "666666", "", "")

    call <SID>X("Structure", s:purple, "", "")              "typedef union struct
    call <SID>X("Type", s:yellow, "", "none")                  "通用type




    " C Highlighting
    call <SID>X("cType", s:yellow, "", "")                  "int char -yellow
    call <SID>X("cStorageClass", s:yellow, "", "")          "const char 中的const 同char一样是黄色
    call <SID>X("cStatement", s:palegoldenrod, "", "bold")  "break;continue; begin end 接近米色 且用粗体
    call <SID>X("cOperator", s:orange, "", "none")          "&& ： ； ？ ++ , - = 操作符 橘红色
    call <SID>X("cBracket", s:red, "", "none")              "{}[]()的颜色
    call <SID>X("cConditional", s:cyan, "", "")              "if else 没必要 也不好配其他色了
    call <SID>X("cRepeat", s:cyan, "", "")                   "for while
    call <SID>X("cFunction", s:blue3, "", "")                   "for while



    "shell script
    call <SID>X("shConditional", s:red, "", "")             "if else


    " Verilog_SystemVerilog Highlighting
    " see /usr/share/vim/vim74/syntax/verilog.vim
    call <SID>X("verilogStatement", s:yellow,"","")         "alway std logic assign buf parameter module
    call <SID>X("verilogRepeat", s:dodgerblue,"","")        "forever repeat while for do while foreach return break continue
    "call <SID>X("verilogNumber", s:azure,"","")             "[] 1'b0 1 001101  if normal is blue then number is azure=white
    call <SID>X("verilogNumber", s:light_green,"","")             "if normal is white then number is blue
    call <SID>X("verilogMethod", s:purple,"","")            "\.start \.finish
    call <SID>X("verilogLabel", s:palegoldenrod,"","bold")      "begin end fork join
    call <SID>X("verilogGlobal", s:tan,"","")               "`else `timescale `define $[a-zA-Z0-9_]\+\>
    call <SID>X("verilogDirective", s:blue,"","")          "synopsys directive -specialdarkblue
    call <SID>X("verilogCharacter", s:chartreuse,"","")     "Character
    call <SID>X("verilogOperator", s:red,"","")         "@ #
    " call <SID>X("verilogConditional", s:blue3,"","")         "if else
    call <SID>X("verilogConditional", s:cyan,"","")         "if else


    " Python Highlighting
    call <SID>X("pythonInclude", s:cyan, "", "")
    call <SID>X("pythonStatement", s:yellow, "", "")
    call <SID>X("pythonConditional", s:light_green, "", "")
    call <SID>X("pythonFunction", s:blue3, "", "")
    call <SID>X("pythonRepeat", s:light_green, "", "")
    call <SID>X("pythonException", s:chartreuse, "", "")
    call <SID>X("pythonPreCondit", s:purple, "", "")
    call <SID>X("pythonExClass", s:orange, "", "")



	" Lua Highlighting
	call <SID>X("luaStatement", s:palegoldenrod, "", "")
	call <SID>X("luaRepeat", s:cyan, "", "")
	call <SID>X("luaCondStart", s:cyan, "", "")
	call <SID>X("luaCondElseif", s:cyan, "", "")
	call <SID>X("luaCond", s:cyan, "", "")
	call <SID>X("luaCondEnd", s:cyan, "", "")

	" Git
	call <SID>X("diffAdded", s:blue, "", "")
	call <SID>X("diffRemoved", s:red, "", "")
	call <SID>X("gitcommitSummary", "", "", "bold")


    " HTML Highlighting
    call <SID>X("htmlTag", s:light_green, "", "")
    call <SID>X("htmlTagName", s:light_green, "", "")
    call <SID>X("htmlArg", s:light_green, "", "")
    call <SID>X("htmlScriptTag", s:light_green, "", "")

    " Diff Highlighting
    call <SID>X("diffAdded", s:chartreuse, "", "")
    call <SID>X("diffRemoved", s:light_green, "", "")

    " Delete Functions
    delf <SID>X
    delf <SID>rgb
    delf <SID>colour
    delf <SID>rgb_colour
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_colour
    delf <SID>grey_level
    delf <SID>grey_number
endif











