%% gmcm.cls — “华为杯”第二十三届中国研究生数学建模竞赛 论文 LaTeX 模板
%%
%% 依据：
%%   附件2 《论文格式规范》       —— 页码 / 字体字号 / 行距 / 参考文献格式
%%   附件3 《论文模板.doc》         —— 封面、摘要页版式
%%   附件4 《人工智能工具及输出使用规定》—— 提供 \ainote / \aitool / \aimark 标注命令
%%
%% 编译：XeLaTeX（推荐 latexmk -xelatex main.tex，输出至 build/）
%%
%% 字体：全部取自本项目 fonts/ 目录，不使用操作系统字体，保证跨平台编译结果一致
%%   西文正文   TeX Gyre Termes（与 Times 同度量）  fonts/texgyretermes-*.otf
%%   西文无衬线 TeX Gyre Heros（与 Helvetica 同度量）fonts/texgyreheros-*.otf
%%   西文等宽   TeX Gyre Cursor（代码清单、\texttt） fonts/texgyrecursor-*.otf
%%   数学       STIX Two Math                       fonts/STIXTwoMath-Regular.otf
%%   中文正文   思源宋体 Source Han Serif SC        fonts/SourceHanSerifSC-*.otf
%%   中文标题   思源黑体 Source Han Sans SC         fonts/SourceHanSansSC-*.otf
%%   中文楷体   霞鹜文楷 LXGW WenKai                fonts/LXGWWenKai-*.ttf
%%   中文仿宋   Fandol Fang                        fonts/FandolFang-Regular.otf
%%   若整体移动 fonts/ 目录，只需修改下方的 \gmcm@fontpath（须以 / 结尾）
%%
%% 全部字体均为开源授权（SIL OFL 1.1 / GPL + font exception），授权全文见 fonts/LICENSES/
%%
%% 类选项：
%%   [coverpagenumber]  封面页脚显示页码 0（与 Word 模板一致）；默认封面不显示页码
%%   [nocover]          不生成封面（仅摘要页 + 正文）
%%   [noshadow]         封面/摘要页标题不加阴影（Word 模板标题带阴影，默认模拟）
%%   其余选项一律忽略并给出警告：本模板禁止引入系统字体，故不接受 fontset= 等选项
%% ---------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gmcm}[2026/10/20 v1.1 GMCM 2026 (Huawei Cup 23rd) paper template]

% ---------------------------------------------------------------------
% 类选项
% ---------------------------------------------------------------------
\newif\if@gmcm@coverpagenumber \@gmcm@coverpagenumberfalse
\newif\if@gmcm@nocover          \@gmcm@nocoverfalse
\newif\if@gmcm@shadow          \@gmcm@shadowtrue
\DeclareOption{coverpagenumber}{\@gmcm@coverpagenumbertrue}
\DeclareOption{nocover}{\@gmcm@nocovertrue}
\DeclareOption{noshadow}{\@gmcm@shadowfalse}
% 未知选项不再透传给 ctexart，避免 fontset=windows 等设置引入操作系统字体
\DeclareOption*{%
  \PackageWarning{gmcm}{未知类选项 `\CurrentOption' 已忽略；%
    本模板的字体固定取自 fonts/ 目录，不支持 fontset 等系统字体选项}}
\ProcessOptions\relax

% ---------------------------------------------------------------------
% 基础文档类：A4 纸，正文小四号（12pt）
%   fontset=none：禁止 ctex 自动选用操作系统字体，所有字体由 fonts/ 目录提供
% ---------------------------------------------------------------------
\LoadClass[UTF8,12pt,a4paper,zihao=-4,fontset=none]{ctexart}

% ---------------------------------------------------------------------
% 基础宏包
%   unicode-math 负责全部数学字形（STIX Two Math），须在 amsmath/amssymb 之后加载；
%   amssymb 先于 unicode-math 加载，可保留 \because 等 AMS 符号，同时数学字母表仍取自 STIX
% ---------------------------------------------------------------------
\RequirePackage{geometry}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{unicode-math}
\RequirePackage{graphicx}
\RequirePackage{booktabs,multirow,array,tabularx,longtable}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage[section]{placeins}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{listings}
\RequirePackage{fancyhdr}
\RequirePackage[titles]{tocloft}
\RequirePackage[normalem]{ulem}
\RequirePackage[hidelinks]{hyperref}

% ---------------------------------------------------------------------
% 页面：按 Word 模板页边距（左右 2.25cm、上 3.0cm、下 2.3cm，页脚居中）
%   格式规范：不能有页眉；页码位于页脚中部
% ---------------------------------------------------------------------
\geometry{a4paper,left=2.25cm,right=2.25cm,top=3.0cm,bottom=2.3cm,
  headheight=0pt,headsep=0pt,footskip=1.1cm}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\zihao{5}\thepage}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}\fancyfoot[C]{\zihao{5}\thepage}}

% ---------------------------------------------------------------------
% 字体：全部从模板自带的 fonts/ 目录加载，不依赖操作系统字体，保证跨平台一致
% ---------------------------------------------------------------------
\def\gmcm@fontpath{fonts/}

% ---- 西文正文：TeX Gyre Termes（与 Times 同度量），供正文、公式中的普通文本使用 ----
\setmainfont[Path=\gmcm@fontpath,
  UprightFont    = texgyretermes-regular.otf,
  BoldFont       = texgyretermes-bold.otf,
  ItalicFont     = texgyretermes-italic.otf,
  BoldItalicFont = texgyretermes-bolditalic.otf]{texgyretermes}

% ---- 西文无衬线：TeX Gyre Heros（与 Helvetica 同度量），供 \textsf / 图表标签使用 ----
\setsansfont[Path=\gmcm@fontpath,
  UprightFont    = texgyreheros-regular.otf,
  BoldFont       = texgyreheros-bold.otf,
  ItalicFont     = texgyreheros-italic.otf,
  BoldItalicFont = texgyreheros-bolditalic.otf]{texgyreheros}

% ---- 西文等宽：TeX Gyre Cursor，供 \texttt 与 listings 代码清单使用 ----
\setmonofont[Path=\gmcm@fontpath,
  UprightFont    = texgyrecursor-regular.otf,
  BoldFont       = texgyrecursor-bold.otf,
  ItalicFont     = texgyrecursor-italic.otf,
  BoldItalicFont = texgyrecursor-bolditalic.otf]{texgyrecursor}

% ---- 数学：STIX Two Math，公式中的数字、字母、运算符与数学字母表全部取自该字体 ----
\setmathfont[Path=\gmcm@fontpath]{STIXTwoMath-Regular.otf}

% ---- 中文：默认罗马族 = 思源宋体（真实 Bold 字重，斜体用霞鹜文楷，与 Word 习惯一致）----
\setCJKmainfont[Path=\gmcm@fontpath,
  BoldFont       = SourceHanSerifSC-Bold.otf,
  ItalicFont     = LXGWWenKai-Regular.ttf,
  BoldItalicFont = LXGWWenKai-Regular.ttf]{SourceHanSerifSC-Regular.otf}
\setCJKsansfont[Path=\gmcm@fontpath,
  BoldFont = SourceHanSansSC-Bold.otf]{SourceHanSansSC-Regular.otf}
\setCJKmonofont[Path=\gmcm@fontpath,AutoFakeBold=2.5]{LXGWWenKai-Regular.ttf}
% ---- 中文字族命令（fontset=none 时 ctex 不再定义，这里自行定义）----
\setCJKfamilyfont{zhsong}[Path=\gmcm@fontpath,
  BoldFont       = SourceHanSerifSC-Bold.otf,
  ItalicFont     = LXGWWenKai-Regular.ttf,
  BoldItalicFont = LXGWWenKai-Regular.ttf]{SourceHanSerifSC-Regular.otf}
\setCJKfamilyfont{zhhei}[Path=\gmcm@fontpath,
  BoldFont = SourceHanSansSC-Bold.otf]{SourceHanSansSC-Regular.otf}
\setCJKfamilyfont{zhkai}[Path=\gmcm@fontpath,AutoFakeBold=2.5]{LXGWWenKai-Regular.ttf}
\setCJKfamilyfont{zhfs}[Path=\gmcm@fontpath,AutoFakeBold=2.5]{FandolFang-Regular.otf}
% 霞鹜文楷为 TrueType 转换字体，script 表信息有限；此处用 CustomDefault（不请求 script 特性）
% 单独处理，可避免 fontspec / xeCJK 的 script 探测警告，不影响汉字显示
\setCJKfamilyfont{zhli}[Path=\gmcm@fontpath,AutoFakeBold=2.5,Script=CustomDefault]{LXGWWenKai-Light.ttf}
% 华文中宋：思源宋体的粗字重（宋体家族中等字重，用于展示性标题）
\setCJKfamilyfont{zhzhongsong}[Path=\gmcm@fontpath]{SourceHanSerifSC-Bold.otf}
\newcommand{\songti}{\CJKfamily{zhsong}}
\newcommand{\heiti}{\CJKfamily{zhhei}}
\newcommand{\kaishu}{\CJKfamily{zhkai}}
\newcommand{\fangsong}{\CJKfamily{zhfs}}
\newcommand{\lishu}{\CJKfamily{zhli}}
\newcommand{\xinwei}{\CJKfamily{zhli}}
\newcommand{\zhongsong}{\CJKfamily{zhzhongsong}}

% ---------------------------------------------------------------------
% 标题：一级标题 四号黑体 居中；其余汉字 小四宋体；单倍行距
% ---------------------------------------------------------------------
\ctexset{
  section = {
    format     = \centering\heiti\zihao{4},
    number     = \arabic{section},      % 如需「一、问题重述」样式，改为 \chinese{section} 并加 name={,、}
    beforeskip = 1.2ex plus .3ex minus .2ex,
    afterskip  = 0.8ex plus .2ex,
  },
  subsection = {
    format     = \raggedright\heiti\zihao{-4},
    beforeskip = 1.0ex plus .2ex,
    afterskip  = 0.5ex plus .1ex,
  },
  subsubsection = {
    format     = \raggedright\heiti\zihao{-4},
    beforeskip = 0.8ex plus .2ex,
    afterskip  = 0.3ex plus .1ex,
  },
}
\linespread{1.15}\selectfont          % 接近 Word「单倍行距」的视觉效果（ctex 默认 1.3 倍行距偏松）
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt plus 1pt}

% ---------------------------------------------------------------------
% 图表与列表
%   图表标题用五号字；表题在上、图题在下
%   公式、图、表均按章编号
% ---------------------------------------------------------------------
\captionsetup{font={small},labelsep=quad,skip=4pt}
\captionsetup[table]{position=above}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\renewcommand{\lstlistingname}{程序}
\numberwithin{equation}{section}
\numberwithin{figure}{section}
\numberwithin{table}{section}

% ---------------------------------------------------------------------
% 定理环境
% ---------------------------------------------------------------------
\newtheorem{theorem}{定理}[section]
\newtheorem{lemma}[theorem]{引理}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{definition}{定义}[section]
\newtheorem{assumption}{假设}

% ---------------------------------------------------------------------
% 代码清单：等宽字体取自 fonts/texgyrecursor-*.otf
% ---------------------------------------------------------------------
\lstset{
  basicstyle=\ttfamily\small,breaklines=true,frame=single,
  numbers=left,numberstyle=\tiny\color{gray},xleftmargin=2.5em,
  keywordstyle=\color{blue!70!black},commentstyle=\color{green!45!black},
  stringstyle=\color{purple!70!black},showstringspaces=false,
  columns=flexible,tabsize=4,
}

% ---------------------------------------------------------------------
% 版面微调：减少浮动体造成的空白，避免 Overfull 警告
% ---------------------------------------------------------------------
\renewcommand{\topfraction}{0.9}\renewcommand{\bottomfraction}{0.85}
\renewcommand{\textfraction}{0.05}\renewcommand{\floatpagefraction}{0.85}
\emergencystretch=1.5em

% ---------------------------------------------------------------------
% 元信息：在 main.tex 中用 \school / \teamnumber / \memberA... 填写
%   \memberA、\memberB、\memberC 为队员姓名，投稿前请填写真实信息
% ---------------------------------------------------------------------
\def\gmcm@series{中国研究生创新实践系列大赛}
\def\gmcm@contestA{“华为杯”第二十三届中国研究生}
\def\gmcm@contestB{数学建模竞赛}

\newcommand{\school}[1]{\def\gmcm@school{#1}}
\newcommand{\teamnumber}[1]{\def\gmcm@teamnumber{#1}}
\newcommand{\memberA}[1]{\def\gmcm@memberA{#1}}
\newcommand{\memberB}[1]{\def\gmcm@memberB{#1}}
\newcommand{\memberC}[1]{\def\gmcm@memberC{#1}}
\newcommand{\keywords}[1]{\def\gmcm@keywords{#1}}
\school{}\teamnumber{}\memberA{}\memberB{}\memberC{}\keywords{}
\let\gmcm@title\@empty
\renewcommand{\title}[1]{\def\gmcm@title{#1}\hypersetup{pdftitle={#1}}}

% ---------------------------------------------------------------------
% 封面（对应 Word 模板第 1 页）
% ---------------------------------------------------------------------
% 标题阴影：模拟 Word 的“阴影”字体效果——先在右下方偏移处画一层灰色，再叠黑字
\newcommand{\gmcm@shadowtext}[1]{%
  \if@gmcm@shadow
    % 颜色切换放在内层 hbox 之外，否则 xeCJK 对行首标点（如“）的压缩会失效，导致两层错位
    \leavevmode\rlap{\hspace{0.05em}\raisebox{-0.05em}{{\color{black!40}\hbox{#1}}}}\hbox{#1}%
  \else #1\fi}
% 封面标题：三行连排、无空行，华文新魏加粗，带阴影
%   中国研究生创新实践系列大赛 —— 小二号；“华为杯”… / 数学建模竞赛 —— 二号
\newcommand{\gmcm@coverhead}{%
  \begin{center}\xinwei\bfseries
    {\zihao{-2}\gmcm@shadowtext{\gmcm@series}\par}
    {\zihao{2}\gmcm@shadowtext{\gmcm@contestA}\par}
    {\zihao{2}\gmcm@shadowtext{\gmcm@contestB}\par}
  \end{center}}
% 摘要页标题：与封面标题相同（第一行小二号，后两行二号），华文新魏加粗带阴影
\newcommand{\gmcm@contesthead}{%
  \begin{center}\xinwei\bfseries
    {\zihao{-2}\gmcm@shadowtext{\gmcm@series}\par}
    {\zihao{2}\gmcm@shadowtext{\gmcm@contestA}\par}
    {\zihao{2}\gmcm@shadowtext{\gmcm@contestB}\par}
  \end{center}}

\newcommand{\makecover}{%
  \if@gmcm@nocover\else
  \begin{titlepage}
    \hypersetup{pageanchor=false}%   % 封面不写页面锚点，避免与摘要页（页码 1）重名
    \if@gmcm@coverpagenumber
      \thispagestyle{plain}\setcounter{page}{0}%
    \else
      \thispagestyle{empty}%
    \fi
    \centering
    \vspace*{0.6cm}\vspace*{-2\baselineskip}     % logo 及其下三行标题整体上移 2 行
    % 四个 logo：研创大赛 / 学位与研究生教育学会 / 华为 / 承办高校
    \includegraphics[height=2.315cm]{figures/logo/cpipc}\hspace{0.5cm}%
    \includegraphics[height=2.646cm]{figures/logo/csgse}\hspace{0.5cm}%
    \includegraphics[height=2.894cm]{figures/logo/huawei}\hspace{0.5cm}%
    \includegraphics[height=2.426cm]{figures/logo/xjtu}\par
    \vspace{1.2cm}
    \gmcm@coverhead
    \vspace{1.6cm}\vspace{1\baselineskip}         % 表格整体上移一行
    % 学校 / 参赛队号 / 队员姓名 表格：小二号宋体加粗
    %   行高由独立支柱控制，避免受 \arraystretch 影响：
    %   学校行 43pt、参赛队号行 55pt（顶部多留 12pt，拉开与学校行的距离）、队员行 31.5pt
    %   线宽：队员姓名之间 1.2pt；学校 / 参赛队号 / 末行 1.7pt
    {\songti\bfseries\zihao{-2}
     \setlength{\extrarowheight}{0pt}
     \setlength{\arrayrulewidth}{1.2pt}
     \renewcommand{\arraystretch}{1.0}
     \def\gmcm@bigstrut{\rule[-11pt]{0pt}{43pt}}%      % 学校行
     \def\gmcm@teamstrut{\rule[-11pt]{0pt}{55pt}}%    % 参赛队号行
     \def\gmcm@smallstrut{\rule[-9.5pt]{0pt}{31.5pt}}% % 队员行
     \begin{tabular}{@{}p{3.2cm}@{}>{\centering\arraybackslash}p{11.4cm}@{}}
       学\quad\quad 校\gmcm@bigstrut & \gmcm@school \\ \specialrule{1.7pt}{0pt}{0pt}
       参赛队号\gmcm@teamstrut       & \gmcm@teamnumber \\ \specialrule{1.7pt}{0pt}{0pt}
       \multirow{3}{*}{队员姓名}
         & \multicolumn{1}{@{}>{\raggedright\arraybackslash}p{11.4cm}@{}}{1.\ \gmcm@memberA\gmcm@smallstrut} \\ \cline{2-2}
         & \multicolumn{1}{@{}>{\raggedright\arraybackslash}p{11.4cm}@{}}{2.\ \gmcm@memberB\gmcm@smallstrut} \\ \cline{2-2}
         & \multicolumn{1}{@{}>{\raggedright\arraybackslash}p{11.4cm}@{}}{3.\ \gmcm@memberC\gmcm@smallstrut} \\ \specialrule{1.7pt}{0pt}{0pt}
     \end{tabular}\par}
    \vfill
  \end{titlepage}
  \hypersetup{pageanchor=true}%      % 恢复页面锚点，供正文交叉引用使用
  \fi}

% ---------------------------------------------------------------------
% 摘要页（对应 Word 模板第 2 页）：题目 / 摘要 / 关键词
%   规范：题目 三号黑体；页码自摘要页起从 1 连续编号，位于页脚中部
%   用法：\begin{abstract} ... \end{abstract}   （摘要一般不超过两页）
% ---------------------------------------------------------------------
\renewenvironment{abstract}{%
  \clearpage
  \setcounter{page}{1}%
  \pagestyle{fancy}\thispagestyle{fancy}%
  \phantomsection\addcontentsline{toc}{section}{摘要}%
  \vspace*{-1\baselineskip}                     % 顶到版心第一行
  \gmcm@contesthead
  \vspace{0.8cm}
  % 题目：三号黑体，下划线
  \noindent{\lishu\zihao{-2}题\hspace{0.5em}目：}%
  {\heiti\zihao{3}\uline{\hspace{1em}\gmcm@title\hspace{1em}}}\par
  \vspace{0.8cm}
  \begin{center}{\lishu\zihao{-2}摘\hspace{0.5em}要：}\end{center}
  \vspace{0.2cm}
  \songti\zihao{-4}\setlength{\parindent}{2em}\ignorespaces
}{%
  \par\vspace{0.8cm}
  \noindent{\lishu\zihao{-2}关键词：}{\songti\zihao{-4}\gmcm@keywords}\par
  \clearpage
}

% ---------------------------------------------------------------------
% 目录：紧跟摘要页，收录 摘要、目录、正文各级标题、参考文献、附录 及页码
%   用法：\tableofcontents（放在 abstract 环境之后）
% ---------------------------------------------------------------------
\setcounter{tocdepth}{3}                                   % 收录到 subsubsection
\renewcommand{\cftsecfont}{\heiti}                         % 一级标题：黑体
\renewcommand{\cftsecpagefont}{\heiti}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}      % 一级标题也加点线
\renewcommand{\cftsubsecfont}{\songti}
\renewcommand{\cftsubsubsecfont}{\songti}
\setlength{\cftbeforesecskip}{4pt}
\setlength{\cftbeforesubsecskip}{1pt}
\setlength{\cftbeforesubsubsecskip}{0pt}
\setlength{\cftsecnumwidth}{2em}
\setlength{\cftsubsecindent}{2em}\setlength{\cftsubsecnumwidth}{2.6em}
\setlength{\cftsubsubsecindent}{4.6em}\setlength{\cftsubsubsecnumwidth}{3.4em}
\renewcommand{\tableofcontents}{%
  \clearpage
  \begin{center}{\heiti\zihao{4}目\hspace{1em}录}\end{center}
  \phantomsection\addcontentsline{toc}{section}{目录}%
  \vspace{0.5ex}
  {\songti\zihao{-4}\@starttoc{toc}}%
  \clearpage}

% ---------------------------------------------------------------------
% 参考文献：按格式规范手写条目（正文引用用 \cite → [1]）
%   书籍：[编号] 作者，书名，出版地：出版社，起止页码，出版年。
%   期刊：[编号] 作者，论文名，杂志名，卷期号：起止页码，出版年。
%   网络：[编号] 作者，资源标题，网址，访问时间（年月日）。
%   AI工具（附件4 第3条）：[编号] 工具名称，版本/型号，开发机构/公司，版本发布日期。
% ---------------------------------------------------------------------
\renewcommand{\refname}{参考文献}
\renewenvironment{thebibliography}[1]{%
  \section*{\refname}%
  \addcontentsline{toc}{section}{\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth \advance\leftmargin\labelsep
        \setlength{\itemsep}{2pt}\setlength{\parsep}{0pt}%
        \@openbib@code \usecounter{enumiv}%
        \let\p@enumiv\@empty \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy\clubpenalty4000\@clubpenalty\clubpenalty\widowpenalty4000\sfcode`\.\@m}
 {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}\endlist}

% ---------------------------------------------------------------------
% 人工智能工具使用标注（附件4）
%   \aitool{名称}{版本/型号}{开发机构/公司}{版本发布日期}  → 生成标准标注串
%   \ainote{...}   数据分析结果前/后的注释（第4条）
%   \aimark{...}   无法确认来源的模型/公式标注（第3条），需同时列入参考文献
%   代码注释（第5条）见 code/ 目录及附录示例
% ---------------------------------------------------------------------
\newcommand{\aitool}[4]{#1（版本/型号：#2；开发机构/公司：#3；版本发布日期：#4）}
\newcommand{\ainote}[1]{\par\noindent{\small\kaishu 注：#1}\par}
\newcommand{\aimark}[1]{\textsuperscript{\textnormal{(AI 辅助)}}\cite{#1}}

% ---------------------------------------------------------------------
% 附录：章号改为 A、B、C …
% ---------------------------------------------------------------------
\let\gmcm@appendix\appendix
\renewcommand{\appendix}{\gmcm@appendix
  \ctexset{section={name={附录,},number=\Alph{section}}}}

\endinput
