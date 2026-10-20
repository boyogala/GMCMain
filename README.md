# GMCM 论文 LaTeX 模板

> “华为杯”第二十三届中国研究生数学建模竞赛论文排版模板
> 依据官方 **附件 2《论文格式规范》**、**附件 3《论文模板.doc》**、**附件 4《人工智能工具及输出使用规定》** 整理。

一套开箱即用的中文数学建模论文模板：**封面 + 摘要页 + 目录 + 七章正文 + 参考文献 + 附录**，自带全部中文字体，不依赖操作系统字体，Windows / macOS / Linux 编译结果一致。

---

## 目录

- [1. 项目简介](#1-项目简介)
- [2. 目录结构](#2-目录结构)
- [3. 环境要求与安装](#3-环境要求与安装)
- [4. 快速开始](#4-快速开始)
- [5. 填写封面与摘要信息](#5-填写封面与摘要信息)
- [6. 编写正文](#6-编写正文)
- [7. 命令与宏速查](#7-命令与宏速查)
- [8. 字体说明](#8-字体说明)
- [9. 格式规范对照表](#9-格式规范对照表)
- [10. AI 工具使用标注](#10-ai-工具使用标注)
- [11. 参考文献格式](#11-参考文献格式)
- [12. 常见问题排查](#12-常见问题排查)
- [13. 提交前自查清单](#13-提交前自查清单)
- [14. 上传到 GitHub](#14-上传到-github)
- [15. 许可与致谢](#15-许可与致谢)

---

## 1. 项目简介

| 项目 | 说明 |
|---|---|
| 适用场景 | 中国研究生数学建模竞赛（GMCM）论文排版 |
| 排版引擎 | **XeLaTeX**（必须，`fontspec` / `unicode-math` 不支持 pdfLaTeX） |
| 文档类 | `gmcm.cls`（封装在 `ctexart` 之上，禁用了系统字体） |
| 中文字体 | **全部内置于 `fonts/`**，逐字嵌入 PDF |
| 西文/数学字体 | TeX Gyre Termes / Heros / Cursor + STIX Two Math（均内置） |
| 交叉引用 | `hyperref`（隐藏超链接边框），目录收录至三级标题 |
| 代码清单 | `listings`，等宽字体取自 TeX Gyre Cursor |
| AI 标注 | 内置 `\ainote` / `\aitool` / `\aimark` 三个命令，落实附件 4 规定 |

**设计原则**：字体全部走 `fonts/` 目录 + `fontset=none`，因此你的论文在不同电脑、不同操作系统上编译出的 PDF 排版完全一致，不会因为换机器缺字体而跑版。

---

## 2. 目录结构

```
GMCMain/
├── main.tex                    主文件：填封面信息 / 题目 / 关键词，\input 各章节
├── gmcm.cls                    文档类：封面、摘要页、字体字号、页码、参考文献、AI 标注命令
├── .latexmkrc                  latexmk 配置（xelatex，输出到 build/）
├── .gitignore                  忽略编译产物，避免把 PDF/日志推送到公开仓库
├── README.md                   本文件
│
├── sections/                   论文正文，按章节拆分
│   ├── abstract.tex            摘要（建模思路 / 方法 / 模型 / 结果 / 创新点 / 关键词）
│   ├── 01_restatement.tex      1 问题重述
│   ├── 02_analysis.tex         2 问题分析（按问题一/二/三拆分）
│   ├── 03_assumptions.tex      3 模型假设与符号说明
│   ├── 04_model_q1.tex         4 问题一模型的建立与求解
│   ├── 05_model_q2.tex         5 问题二模型的建立与求解
│   ├── 06_model_q3.tex         6 问题三模型的建立与求解
│   ├── 07_evaluation.tex       7 模型的评价与推广
│   ├── references.tex          参考文献（thebibliography 手写条目）
│   └── appendix.tex            附录（代码清单、AI 使用说明）
│
├── code/                       论文附录中的程序
│   └── solve_q1.py             问题一求解代码示例（含附件 4 要求的 AI 辅助编程注释）
│
├── figures/
│   └── logo/                   封面四个 logo（研创大赛 / 学位与研究生教育学会 / 华为 / 承办高校）
│
├── fonts/                      模板自带字体（只从此目录加载，不依赖系统字体）
│
└── build/                      编译产物（已 gitignore，不入库）
```

> `code/solve_q2.py`、`data/` 等在 `sections/appendix.tex` 中作为清单条目列出，**需要自行补充**。

---

## 3. 环境要求与安装

### 3.1 最低要求

| 组件 | 版本要求 | 说明 |
|---|---|---|
| TeX Live / MacTeX | **2020 及以上**（测试于 TeX Live 2023） | 需包含 XeTeX |
| `ctex` | 随 texlive-lang-chinese | 中文排版 |
| `unicode-math` | 随 texlive-latex-extra | 数学字体 |
| `latexmk` | 随 latexmk 包 | 自动化编译 |
| Python 3 | 3.8+ | 仅运行 `code/` 中的示例代码 |
| numpy / scipy | 任意较新版本 | 仅运行 `code/solve_q1.py` |

### 3.2 需要的 LaTeX 宏包

以下宏包均由 `gmcm.cls` 自动加载，**无需**在自己的 `.tex` 里重复 `\usepackage`：

```
ctexart(基础)  geometry  amsmath  amssymb  amsthm  unicode-math  graphicx
booktabs  multirow  array  tabularx  longtable  caption  subcaption  float
placeins  enumitem  xcolor  listings  fancyhdr  tocloft  ulem  hyperref
```

### 3.3 各平台安装

**Ubuntu / Debian**

```bash
sudo apt update
sudo apt install texlive-xetex texlive-lang-chinese texlive-latex-extra \
                 texlive-latex-recommended texlive-fonts-recommended latexmk
```

**macOS（MacTeX）**
安装 [MacTeX](https://www.tug.org/mactex/)（或 BasicTeX + 上述包），TeX 选择 XeLaTeX。

**Windows（TeX Live）**
安装 [TeX Live](https://tug.org/texlive/)，用 TeXworks 打开 `main.tex`，编译器选 **XeLaTeX**；或直接用命令行：

```powershell
latexmk -xelatex main.tex
```

**在线编译（Overleaf）**
新建项目 → 上传整个 `GMCMain` 文件夹 → 编译器选择 **XeLaTeX**。注意 Overleaf 不允许上传中文字体时，请在本地编译好 PDF 后上传。

### 3.4 验证环境

```bash
xelatex --version      # 应显示 XeTeX 3.14x
latexmk --version      # 应为 4.x
kpsewhich ctex.sty unicode-math.sty listings.sty tocloft.sty
```

---

## 4. 快速开始

```bash
cd GMCMain
latexmk -xelatex main.tex
```

编译完成后 PDF 输出到 **`build/main.pdf`**（输出目录由 `.latexmkrc` 的 `$out_dir` 控制）。

### 4.1 常用编译命令

| 命令 | 说明 |
|---|---|
| `latexmk -xelatex main.tex` | **推荐**：自动判断需要重跑几次（最多 3 次），生成 `build/main.pdf` |
| `xelatex -interaction=nonstopmode -file-line-error main.tex` | 单次编译；改动了目录/页码后**再跑一遍** |
| `xelatex -output-directory=build main.tex` | 单次编译并手动指定输出目录 |
| `latexmk -c main.tex` | 清理中间文件（保留 PDF） |
| `latexmk -C main.tex` | 清理全部产物（含 PDF） |
| `latexmk -xelatex -g main.tex` | 强制从头重编（改了类文件后使用） |

> `.latexmkrc` 中已设置 `-no-shell-escape`，因此 `\write18` 等需要外部命令的功能不可用；这是为了保证在线编译与本地编译一致且安全。

### 4.2 编译流程说明

1. **XeLaTeX** 处理 `main.tex` → 生成 `.xdv`
2. **xdvipdfmx** 把 `.xdv` 转成 `.pdf`（字体在此步嵌入）
3. 由于目录、页码需要多轮收敛，`latexmk` 会自动重复第 1–2 步

### 4.3 常见编译位置提示

- **必须在项目根目录执行编译**。`\input{sections/...}`、`\includegraphics{figures/...}`、`\lstinputlisting{code/...}` 的路径均相对于项目根目录解析。
- 若在其他目录编译，请在 `main.tex` 中加 `\graphicspath{{figures/}}` 并把 `\input` 改为带路径的写法，或用 `-output-directory` 指定输出目录但仍在根目录执行。

---

## 5. 填写封面与摘要信息

所有封面与摘要页信息集中在 `main.tex` 顶部（前导区）填写：

```latex
\documentclass{gmcm}

\school{你的大学名称}                 % 学校
\teamnumber{参赛队号}                 % 参赛队号
\memberA{队员1}                      % 队员 1
\memberB{队员2}                      % 队员 2
\memberC{队员3}                      % 队员 3
\title{研究生 数学建模 题目}          % 论文题目（显示在摘要页“题目：”之后）
\keywords{关键词1；关键词2；关键词3；关键词4}

\begin{document}
\makecover          % 生成封面页（不计页码）
\begin{abstract}    % 生成摘要页（页码从 1 开始）
\input{sections/abstract}
\end{abstract}
\tableofcontents    % 生成目录页
...
\end{document}
```

### 5.1 各命令说明

| 命令 | 作用 | 备注 |
|---|---|---|
| `\school{...}` | 封面「学校」栏 | 封面表格第一行 |
| `\teamnumber{...}` | 封面「参赛队号」栏 | |
| `\memberA{...}` `\memberB{...}` `\memberC{...}` | 三位队员姓名 | 按顺序编号 1./2./3. |
| `\title{...}` | 摘要页论文题目 | 同时写入 PDF 元数据 `pdftitle` |
| `\keywords{...}` | 摘要页关键词 | 多个关键词用中文分号「；」分隔 |
| `\makecover` | 输出封面页 | 置于 `\begin{document}` 后 |
| `abstract` 环境 | 输出摘要页 | 页码从 1 开始，关键词自动排在摘要后 |
| `\tableofcontents` | 输出目录 | 收录至三级标题 |

> **注意**：`\title` 在本模板中被重定义为“保存标题字符串”，**不会**自动生成标题页，请勿使用 LaTeX 原生的 `\maketitle`。
> 所有这些命令必须写在 `\begin{document}` **之前**。

### 5.2 隐私提醒（重要）

本模板默认全部使用占位符。若仓库要公开托管：

- ✅ 提交前把 `\school` / `\teamnumber` / `\memberA..C` **保持为占位符**；
- ✅ 真实身份信息只在本机填写并本地编译；
- ✅ PDF 成品通过竞赛官方渠道提交，**不要**推到公开仓库；
- ✅ `build/` 已在 `.gitignore` 中，但请在推送前用 `git status` 再确认一次。

---

## 6. 编写正文

### 6.1 章节组织

正文章节各自独立成文件，在 `main.tex` 中用 `\input` 引入。新增/删除章节时，**同步修改 `main.tex`** 的 `\input` 顺序（章节编号由 LaTeX 自动按出现顺序生成，无需手写编号）。

`\section` 一级标题自动为 **四号黑体居中**；`\subsection` / `\subsubsection` 为 **小四黑体左对齐**。

### 6.2 各章写作要点

| 章节文件 | 应包含的内容 |
|---|---|
| `sections/abstract.tex` | 建模思路 → 各问题的主要方法与模型 → 结果与结论 → 创新点；**不超过 2 页**；末尾列出关键词 |
| `sections/01_restatement.tex` | 问题背景、问题重述；用自己的语言转述，**不要照抄题面**，不得出现学校、姓名等身份标志 |
| `sections/02_analysis.tex` | 针对问题一 / 二 / 三分别说明思路与所用方法 |
| `sections/03_assumptions.tex` | 合理假设（编号列出）；符号说明表（用 `booktabs` 的 `\toprule/\midrule/\bottomrule`） |
| `sections/04_model_q1.tex` | 模型建立（目标函数 + 约束条件，带公式编号与 `\label`）→ 模型求解 → 结果分析 |
| `sections/05_model_q2.tex` | 同上，对应问题二 |
| `sections/06_model_q3.tex` | 同上，对应问题三 |
| `sections/07_evaluation.tex` | 模型优点、模型缺点、模型改进与推广 |
| `sections/references.tex` | `thebibliography` 手写条目，正文用 `\cite{ref-key}` 引用 |
| `sections/appendix.tex` | 程序清单、补充推导、AI 使用说明 |

### 6.3 插图

把图片放到 `figures/` 下，在正文用相对路径引用：

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.7\linewidth]{figures/your_figure.png}
  \caption{图注文字}
  \label{fig:your-label}
\end{figure}
```

- 图/表/公式**按章编号**（如“图 4-1”“表 3-1”“式 (4-1)”），由 `\numberwithin` 自动完成。
- 图题在图**下方**，表题在表**上方**（`caption` 已配置 `position=above` 用于 table）。
- 图表标题字号为五号。
- 封面 logo 路径在 `gmcm.cls` 中写死为 `figures/logo/`，替换 logo 时保持文件名即可。

### 6.4 表格

```latex
\begin{table}[H]
  \centering
  \caption{表题文字}
  \label{tab:your-label}
  \begin{tabular}{clc}
    \toprule
    符号 & 含义 & 单位 \\
    \midrule
    $x_i$ & 说明文字 & -- \\
    \bottomrule
  \end{tabular}
\end{table}
```

`[H]` 来自 `float` 包，用于让表格就地放置、不浮动。

### 6.5 公式与交叉引用

```latex
\begin{equation}
  \min_{x}\; f(x)=\sum_{i=1}^{n} c_i x_i,
  \qquad \text{s.t.}\quad Ax\le b,\; x\ge 0 .
  \label{eq:q1-obj}
\end{equation}
```

正文用 `\eqref{eq:q1-obj}` 引用公式、`\ref{fig:...}` / `\ref{tab:...}` 引用图表。**新增带 `\label` 的公式或图表后需重新编译两遍**，交叉引用编号才正确。

### 6.6 代码清单

```latex
\lstinputlisting[language=Python,caption={问题一求解程序}]{code/solve_q1.py}
```

`listings` 已配置：等宽字体、行号、自动换行、单边框、关键字/注释/字符串高亮。

### 6.7 定理环境

类中已定义：`theorem`（定理）、`lemma`（引理）、`proposition`（命题）、`definition`（定义）、`assumption`（假设），均按章编号。

```latex
\begin{theorem}[条件]
\label{thm:xxx}
正文……
\end{theorem}
```

---

## 7. 命令与宏速查

### 7.1 类选项

在 `\documentclass{gmcm}` 的方括号中填写：

| 选项 | 作用 |
|---|---|
| `coverpagenumber` | 封面页脚显示页码 `0`（与 Word 模板一致）；默认封面不显示页码 |
| `nocover` | 不生成封面，仅输出摘要页 + 正文 |
| `noshadow` | 封面/摘要页大标题不加阴影（默认按 Word 模板模拟阴影） |

> 其他选项（如 `fontset=windows`）**一律忽略并给出警告**，以保证字体始终来自 `fonts/`。

### 7.2 中文字族命令

`fontset=none` 时 ctex 不再自动定义中文族，模板自行提供：

| 命令 | 字体 | 用途 |
|---|---|---|
| `\songti` | 宋体 | 正文（`\rmfamily` 默认） |
| `\heiti` | 黑体 | 标题 |
| `\kaishu` | 楷体 | 中文斜体、`\ainote` 注释 |
| `\fangsong` | 仿宋 | 等宽中文 |
| `\lishu` | 隶书 | 摘要页“题目/摘要/关键词” |
| `\xinwei` | 华文新魏 | 封面/摘要页大标题 |
| `\zhongsong` | 华文中宋 | 备用 |

### 7.3 章节与编号

| 需求 | 做法 |
|---|---|
| 一级标题用「一、二、三」 | `\ctexset{section={number=\chinese{section}, name={,、}}}`（写在导言区） |
| 附录章号 A / B / C | 已默认启用 `\Alph{section}`，章名显示为「附录A、」 |
| 目录收录到四级 | `\setcounter{tocdepth}{4}` |

### 7.4 表格线

`booktabs` 提供：`\toprule`（顶线）、`\midrule`（中线）、`\bottomrule`（底线）、`\cmidrule{2-3}`（局部中线）。

---

## 8. 字体说明

所有字体只从 `fonts/` 目录加载，PDF 中嵌入的就是这批文件本身，**跨平台排版完全一致**。

| 用途 | 字体 | 文件 |
|---|---|---|
| 正文西文 `\rmfamily` | TeX Gyre Termes（Times 同度量） | `fonts/texgyretermes-*.otf` |
| 西文无衬线 `\sffamily` | TeX Gyre Heros（Helvetica 同度量） | `fonts/texgyreheros-*.otf` |
| 西文等宽 `\ttfamily` / `listings` | TeX Gyre Cursor（等宽） | `fonts/texgyrecursor-*.otf` |
| 数学 | STIX Two Math | `fonts/STIXTwoMath-Regular.otf` |
| 正文 / `\songti` | 宋体 | `fonts/SimSun.ttc` |
| 标题 / `\heiti` | 黑体 | `fonts/SimHei.ttf` |
| `\kaishu`、中文斜体 | 楷体 | `fonts/SimKai.ttf` |
| `\fangsong` | 仿宋 | `fonts/SimFang.ttf` |
| 封面/摘要页标题 `\xinwei` | 华文新魏 | `fonts/STXinwei.ttf` |
| `\zhongsong` | 华文中宋 | `fonts/STZhongsong.ttf` |
| 摘要页「题目/摘要/关键词」 `\lishu` | 隶书 | `fonts/LiSu.ttf` |

- 数学字体由 `unicode-math` 统一设置为 **STIX Two Math**：公式中的数字、字母、运算符，以及 `\mathbb`、`\mathcal`、`\mathfrak`、`\mathscr` 等数学字母表全部取自该文件，**不会**回落到 Computer Modern / AMS 字体。
- **移动 `fonts/` 目录**：修改 `gmcm.cls` 第 86 行的 `\def\gmcm@fontpath{fonts/}`（路径**必须以 `/` 结尾**）。
- **字体授权提醒**：TeX Gyre（`GUST Font License`）与 STIX Two Math（`SIL OFL 1.1`）可自由使用；而宋体/黑体/楷体/仿宋/隶书/华文新魏/华文中宋属于中易（ZhongYi）公司的商业字体，**再分发可能涉及版权问题**。若仓库对外公开，请自行评估是否改用开源字体（如思源宋体/黑体、Fandol 系列）或从 `fonts/` 中移除商业字体并在本地另装。
- `LiSu.ttf` 不含 OpenType script 表，类中已用 `Script=CustomDefault` 单独处理，避免 fontspec 警告。

---

## 9. 格式规范对照表

| 官方规范（附件 2） | 模板实现 |
|---|---|
| 题目、摘要、关键词写在摘要页；下一页开始正文 | `abstract` 环境自动生成摘要页；`\title`、`\keywords` 填写 |
| 目录（摘要之后） | `\tableofcontents` 生成，收录 摘要、目录、各级标题（到三级）、参考文献、附录 及页码 |
| 页码从摘要页起、页脚中部、阿拉伯数字从 1 连续编号 | 封面默认无页码（`coverpagenumber` 可显示 0），摘要页 `\setcounter{page}{1}` |
| 不能有页眉 | `fancyhdr` 已清空页眉，`\headrulewidth=0pt` |
| 不得出现答题人身份标志 | `fancyhdr` 已清空页眉；**正文中不要写学校/姓名** |
| 题目三号黑体 | 摘要页 `\heiti\zihao{3}` + 下划线 |
| 一级标题四号黑体居中 | `\section` 为 `\centering\heiti\zihao{4}` |
| 其余汉字小四宋体、单倍行距 | `zihao=-4`，`\linespread{1.15}`（Word 单倍行距视觉等价） |
| 摘要 ≤ 2 页，含建模思路/方法/模型/结果/创新点/关键词 | `sections/abstract.tex` 已按要素留空 |
| 正文引用 `[1][3]`，引书籍注页码；按引用次序排列 | `\cite{}` + `thebibliography` |
| 页面 A4，页边距上下左右固定 | `geometry`：左右 2.25cm、上 3.0cm、下 2.3cm，页脚距正文 1.1cm |

---

## 10. AI 工具使用标注

附件 4《人工智能工具及输出使用规定》对应到模板的三个命令：

| 条款 | 要求 | 模板命令 |
|---|---|---|
| 第 3 条 | 无法确认来源的 AI 输出模型/公式须标注，并在参考文献中列出工具名称、版本/型号、开发机构、发布日期（有不被认可风险） | `\aimark{ref-ai}` + `\bibitem{ref-ai}` |
| 第 4 条 | 数据分析结果前/后加注释，写明来自 AI 工具及其名称、版本、机构、日期 | `\ainote{... \aitool{名称}{版本}{机构}{日期} ...}` |
| 第 5 条 | AI 辅助编程须在程序前加注释 | 见 `code/solve_q1.py` 文件头注释 |
| 第 2 条 | 最终文字必须用参赛队自身语言表述 | —— |
| 第 6 条 | 赛题要求时提供 AI 输入内容及后续处理策略 | 可放在 `sections/appendix.tex` |

### 用法

```latex
% 第 3 条：公式/模型标注
提出如下规划模型 \aimark{ref-ai}：

% 第 4 条：数据分析结果注释
\ainote{上述聚类结果由 AI 辅助生成，工具为 \aitool{工具名}{版本号}{开发机构}{2026-01-01} 生成并经人工校验。}

% 参考文献中对应条目（第 3 条要求）
%   \bibitem{ref-ai} XXX（版本/型号：X.X；开发机构/公司：XXX 公司；版本发布日期：2026-XX-XX）
```

| 命令 | 参数 | 输出 |
|---|---|---|
| `\aitool{名称}{版本/型号}{开发机构/公司}{版本发布日期}` | 4 个 | 标准标注串 |
| `\ainote{内容}` | 1 个 | 小五楷体「注：……」独立成段 |
| `\aimark{文献键}` | 1 个 | 上标 `(AI 辅助)` + `\cite{}` |

> ⚠ **违反规定将取消评奖资格**，请务必按要求逐条标注。

---

## 11. 参考文献格式

`sections/references.tex` 中的条目按官方规范手写，三种表述方式：

```latex
\begin{thebibliography}{99}
  % 书籍：[编号] 作者，书名，出版地：出版社，起止页码，出版年。
  \bibitem{ref-book}    张维良，数学建模方法及其应用，北京：清华大学出版社，15--23，2020.

  % 期刊：[编号] 作者，论文名，杂志名，卷期号：起止页码，出版年。
  \bibitem{ref-journal} 某某，某问题的研究，系统工程学报，40(3)：567--578，2020.

  % 网络：[编号] 作者，资源标题，网址，访问时间（年月日）。
  \bibitem{ref-web}     某某，公开数据集名称，\url{https://example.com/dataset}，2026年10月16日。
\end{thebibliography}
```

正文引用：`<文献内容>\cite{ref-book}\cite{ref-journal}。` → 渲染为 `[1][2]`。

- 条目**按引用先后顺序**排列；
- 未被引用的条目不要放进 `thebibliography`（LaTeX 不会自动剔除）；
- 中文著作需在 `\bibitem` 后加 `[\!1]` 之类的语言标记时，注意与上标不冲突。

---

## 12. 常见问题排查

| 现象 | 原因与解决 |
|---|---|
| `! LaTeX Error: File 'ctex.sty' not found.` | TeX 发行版不完整。安装 `texlive-lang-chinese`、`texlive-latex-extra` |
| `! Font \TU/xxx(0)/m/n not loadable` 或中文全是方框 | 字体文件缺失。确认 `fonts/` 目录完整，且 `\gmcm@fontpath` 指向正确路径 |
| `! Package inputenc Error` / 出现乱码 | 用了 pdfLaTeX。**必须**使用 XeLaTeX |
| `Missing character: There is no … in font` | 字体中没有该字形（如 `LiSu.ttf` 缺生僻字）。改用 `\heiti`/`\songti`，或换用支持该字的字体 |
| `Package gmcm Warning: 未知类选项 'xxx' 已忽略` | 模板不支持 `fontset=` 等选项，属预期行为，可忽略 |
| 目录页码或引用编号不对 | 交叉引用需两遍编译。运行 `latexmk -xelatex main.tex` 或再执行一次 `xelatex` |
| 改了章节后目录没更新 | 同上；必要时 `latexmk -C main.tex` 后重编 |
| `! LaTeX Error: File 'figures/xxx.png' not found` | 图片路径相对**项目根目录**解析。确认在根目录编译、图片路径正确 |
| `! LaTeX Error: File 'code/xxx.py' not found` | 同上，`\lstinputlisting` 路径亦相对于根目录 |
| 大量 `Overfull \hbox` | 表格过宽或长英文单词。换行位置不当可加 `\sloppy`；表格列过多时改用 `tabularx` 或缩小 `\tabcolsep` |
| 图片在 PDF 中模糊 | 源图分辨率过低。PNG 建议 ≥ 300 dpi；优先用矢量图（PDF/EPS） |
| Windows 下编译慢/中断 | 路径含中文或空格可能导致问题，建议用纯英文路径；用 TeXworks 选 XeLaTeX |
| 想关闭封面 | `\documentclass[nocover]{gmcm}` |
| 想在封面显示页码 0 | `\documentclass[coverpagenumber]{gmcm}` |

---

## 13. 提交前自查清单

### 13.1 内容与格式

- [ ] 摘要 ≤ 2 页，包含建模思路、方法、模型、结果、创新点、关键词
- [ ] 关键词 3–5 个，用中文分号分隔
- [ ] 目录收录到三级标题，页码正确
- [ ] 页码从摘要页起为 1，封面无页码（或按要求显示 0），全文无页眉
- [ ] 一级标题四号黑体居中，正文小四宋体
- [ ] 图题在下、表题在上，图表按章编号
- [ ] 公式编号按章编号，交叉引用无 `??`
- [ ] 参考文献按引用顺序排列，格式符合三种表述方式之一
- [ ] **正文中不出现学校、姓名、队号等身份标志**
- [ ] 附录含必要的程序清单与数据说明

### 13.2 AI 使用标注（附件 4）

- [ ] AI 生成的模型/公式用 `\aimark{}` 标注，且参考文献中列有对应工具条目
- [ ] AI 生成的数据分析结果前后有 `\ainote{}` 注释，写明名称、版本、机构、日期
- [ ] AI 辅助编写的程序在文件头有注释说明
- [ ] 最终文字为队伍自身表述

### 13.3 隐私与仓库安全

- [ ] `main.tex` 中的 `\school` / `\teamnumber` / `\memberA..C` 仍为占位符
- [ ] `git status` 中不含 `build/`、`*.pdf`、`*.log` 等产物
- [ ] 未提交任何原始数据、密钥、`.env`、题面文件
- [ ] 提交历史中没有被删除但仍可检索到的身份信息
- [ ] 已确认仓库公开 / 私有属性符合预期

---

## 14. 上传到 GitHub

> 认证方式：**Personal access tokens (classic)**（HTTPS）。PAT 代替 GitHub 账户密码。

### 14.1 创建 PAT classic

1. GitHub → 头像 → **Settings** → **Developer settings**
2. **Personal access tokens → Tokens (classic)** → **Generate new token (classic)**
3. 设置名称与**到期时间**（不要选永久有效）
4. 勾选权限：推送到私有仓库需 **`repo`**；只推公开仓库 **`public_repo`** 即可
5. 生成后**立即复制**（只显示一次）。若仓库属于启用了 SSO 的组织，还需点 **Configure SSO** 授权

> 令牌等同于账户密码，切勿写进脚本、远程地址或提交记录。

### 14.2 初始化并推送

```bash
cd GMCMain

# 1) 初始化仓库（若已有 .git 则跳过）
git init -b main

# 2) 配置提交者身份（仅首次）
git config --global user.name "你的名字"
git config --global user.email "你的 GitHub 邮箱"

# 3) 添加远程仓库（先在 GitHub 上创建同名空仓库，不要勾选 README/.gitignore/License）
git remote add origin https://github.com/<你的用户名>/GMCMain.git

# 4) 暂存并提交
git add .
git status          # ← 提交前务必确认列表里没有 PDF、日志和任何敏感信息
git commit -m "Initial commit: GMCM LaTeX template"

# 5) 推送
git push -u origin HEAD
```

推送时提示凭据：

- **Username**：GitHub 用户名
- **Password**：粘贴 PAT（**不是账户密码**；终端不回显属正常）

### 14.3 后续更新

```bash
git add .
git commit -m "描述本次修改"
git push
```

### 14.4 常见问题

| 现象 | 说明 |
|---|---|
| `remote: Password authentication is not supported` | 输成了账户密码，应使用 PAT |
| `403 Permission denied` | PAT 缺 `repo`/`public_repo` 权限、已过期，或仓库所有者不对；组织仓库还要检查 SSO 授权 |
| `refusing to merge unrelated histories` | GitHub 仓库创建时勾选了 README 等初始文件。本地先 `git pull origin main --allow-unrelated-histories` 合并，**不要**直接强推 |
| `src refspec ... does not match any` | 尚无提交，或分支名不符。先确认 `git status`、`git branch --show-current` |
| 每次都要重新输入令牌 | 可配置 Git Credential Manager / GitHub CLI 等凭据管理器；**不要**用明文存储的方式 |

---

## 15. 许可与致谢

- **模板代码**（`gmcm.cls`、`main.tex`、`sections/`、`code/`、`README.md`）：可自由修改使用。
- **西文与数学字体**：TeX Gyre 系列为 GUST Font License，STIX Two Math 为 SIL Open Font License 1.1。
- **中文字体**：宋体 / 黑体 / 楷体 / 仿宋 / 隶书 / 华文新魏 / 华文中宋为中易（ZhongYi）公司商业字体，**再分发可能涉及版权**，公开仓库请自行评估。
- **封面 logo**：中国研究生创新实践系列大赛 / 学位与研究生教育学会 / 华为 / 西安交通大学等标识归各自权利人所有，仅用于竞赛论文版式，请遵守各自的使用规范。
- 本模板依据官方附件 2 / 3 / 4 整理，最终格式请以官方发布的最新文件为准。
