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
- [9. 商业字体的替换与合规说明](#9-商业字体的替换与合规说明)
- [10. 格式规范对照表](#10-格式规范对照表)
- [11. AI 工具使用标注](#11-ai-工具使用标注)
- [12. 参考文献格式](#12-参考文献格式)
- [13. 常见问题排查](#13-常见问题排查)
- [14. 提交前自查清单](#14-提交前自查清单)
- [15. 上传到 GitHub](#15-上传到-github)
- [16. 许可与致谢](#16-许可与致谢)

---

## 1. 项目简介

| 项目 | 说明 |
|---|---|
| 适用场景 | 中国研究生数学建模竞赛（GMCM）论文排版 |
| 排版引擎 | **XeLaTeX**（必须，`fontspec` / `unicode-math` 不支持 pdfLaTeX） |
| 文档类 | `gmcm.cls`（封装在 `ctexart` 之上，禁用了系统字体） |
| 中文字体 | **全部内置于 `fonts/` 且均为开源字体**（思源宋体 / 思源黑体 / 霞鹜文楷 / Fandol 仿宋），逐字嵌入 PDF |
| 西文/数学字体 | TeX Gyre Termes / Heros / Cursor + STIX Two Math（均内置，均开源授权） |
| 交叉引用 | `hyperref`（隐藏超链接边框），目录收录至三级标题 |
| 代码清单 | `listings`，等宽字体取自 TeX Gyre Cursor |
| AI 标注 | 内置 `\ainote` / `\aitool` / `\aimark` 三个命令，落实附件 4 规定 |

**设计原则**：字体全部走 `fonts/` 目录 + `fontset=none`，因此你的论文在不同电脑、不同操作系统上编译出的 PDF 排版完全一致，不会因为换机器缺字体而跑版；同时**不依赖任何系统字体，也不含任何商业字体**，可以放心公开托管。

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
├── fonts/                      模板自带字体（**全部开源**，只从此目录加载，不依赖系统字体）
│   └── LICENSES/               各字体的授权全文（OFL 1.1 / GPL+font exception）
│
├── filedeleted/                已停用的商业字体留档（**已被 .gitignore 排除，不入库**）
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

`fontset=none` 时 ctex 不再自动定义中文族，模板自行提供（全部为开源字体）：

| 命令 | 实际字体 | 用途 |
|---|---|---|
| `\songti` | 思源宋体 Source Han Serif SC | 正文（`\rmfamily` 默认） |
| `\heiti` | 思源黑体 Source Han Sans SC | 标题 |
| `\kaishu` | 霞鹜文楷 LXGW WenKai | 中文斜体、`\ainote` 注释 |
| `\fangsong` | Fandol 仿宋 | 仿宋（备用） |
| `\lishu` | 霞鹜文楷 Light | 摘要页“题目/摘要/关键词” |
| `\xinwei` | 霞鹜文楷 Light | 封面/摘要页大标题 |
| `\zhongsong` | 思源宋体 Bold | 备用 |

> 这套命令名沿用 Word 模板的「宋体/黑体/楷体/仿宋/隶书/华文新魏/华文中宋」命名，便于对照官方格式规范；**实际调用的是上表中的开源字体**。如需改用别的字体，只需改 `gmcm.cls` 中对应的 `\setCJKfamilyfont`，命令名保持不变。

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

所有字体**只从 `fonts/` 目录加载**，PDF 中嵌入的就是这批文件本身，**跨平台排版完全一致**，
且**全部为开源授权字体**，可自由随仓库分发。

| 用途 | 字体 | 文件 | 授权 |
|---|---|---|---|
| 正文西文 `\rmfamily` | TeX Gyre Termes（Times 同度量） | `fonts/texgyretermes-*.otf` | GUST Font License |
| 西文无衬线 `\sffamily` | TeX Gyre Heros（Helvetica 同度量） | `fonts/texgyreheros-*.otf` | GUST Font License |
| 西文等宽 `\ttfamily` / `listings` | TeX Gyre Cursor（等宽） | `fonts/texgyrecursor-*.otf` | GUST Font License |
| 数学 | STIX Two Math | `fonts/STIXTwoMath-Regular.otf` | SIL OFL 1.1 |
| 正文 / `\songti` | 思源宋体 Source Han Serif SC | `fonts/SourceHanSerifSC-Regular.otf`（+`-Bold.otf`） | SIL OFL 1.1 |
| 标题 / `\heiti` | 思源黑体 Source Han Sans SC | `fonts/SourceHanSansSC-Regular.otf`（+`-Bold.otf`） | SIL OFL 1.1 |
| `\kaishu`、中文斜体 | 霞鹜文楷 LXGW WenKai | `fonts/LXGWWenKai-Regular.ttf` | SIL OFL 1.1 |
| `\fangsong` | Fandol 仿宋 | `fonts/FandolFang-Regular.otf` | GPL v3 + font exception |
| 摘要页「题目/摘要/关键词」 `\lishu` | 霞鹜文楷 Light | `fonts/LXGWWenKai-Light.ttf` | SIL OFL 1.1 |
| 封面/摘要页标题 `\xinwei` | 霞鹜文楷 Light | `fonts/LXGWWenKai-Light.ttf` | SIL OFL 1.1 |
| `\zhongsong` | 思源宋体 Bold | `fonts/SourceHanSerifSC-Bold.otf` | SIL OFL 1.1 |

授权全文见 `fonts/LICENSES/`。

- 数学字体由 `unicode-math` 统一设置为 **STIX Two Math**：公式中的数字、字母、运算符，以及 `\mathbb`、`\mathcal`、`\mathfrak`、`\mathscr` 等数学字母表全部取自该文件，**不会**回落到 Computer Modern / AMS 字体。
- 中文**粗体使用真实 Bold 字重**（思源宋体 / 思源黑体各自的 Bold 文件），而不是伪加粗；霞鹜文楷与 Fandol 仿宋无粗体字重，使用 `AutoFakeBold=2.5` 伪加粗。
- **中文斜体**按 Word 排版习惯用楷体代替（`ItalicFont=LXGWWenKai-Regular.ttf`）。
- **移动 `fonts/` 目录**：修改 `gmcm.cls` 中的 `\def\gmcm@fontpath{fonts/}`（路径**必须以 `/` 结尾**）。
- **确认没有系统字体混入**：编译后执行 `pdffonts build/main.pdf`，输出中应只出现 `SourceHanSerif*` / `SourceHanSans*` / `LXGWWenKai*` / `FandolFang*` / `TeXGyre*` / `STIXTwoMath*`；若出现其他字体名，说明有字体回退，需要检查 `fonts/` 是否完整。
- 霞鹜文楷为 TrueType 转换字体，script 表信息有限，类中已用 `Script=CustomDefault` 单独处理，避免 fontspec 警告。

---

## 9. 商业字体的替换与合规说明

> 本项目的**中文字体已全部替换为开源字体**，`fonts/` 目录中不含任何商业字体，可以放心公开托管。
> 本节记录替换过程与结论，便于追溯与二次开发。

### 9.1 替换前的字体与授权状况

早期版本使用中易（ZhongYi）等公司的商业中文字体，其 `name` 表信息如下：

| 原字体文件 | 原字体名 | 版权方 | `fsType` | 可否随仓库再分发 |
|---|---|---|---|---|
| `SimSun.ttc` | 宋体 SimSun | Beijing ZhongYi Electronics Co. | `0x0008` Editable | ❌ **不建议** |
| `SimHei.ttf` | 黑体 SimHei | Beijing ZhongYi Electronics Co. 1995–2005 | `0x0008` Editable | ❌ **不建议** |
| `SimKai.ttf` | 楷体 KaiTi | Beijing ZhongYi Electronics Co. 1995–2005 | `0x0008` Editable | ❌ **不建议** |
| `SimFang.ttf` | 仿宋 FangSong | Beijing ZhongYi Electronics Co. 1995–2005 | `0x0008` Editable | ❌ **不建议** |
| `LiSu.ttf` | 隶书 LiSu | Stone Co. 1996 | `0x0000` Installable Embedding | ❌ **不建议** |
| `STXinwei.ttf` | 华文新魏 STXinwei | Changzhou SinoType Technology Co., Ltd. 1991–1998 | `0x0008` Editable | ❌ **不建议** |
| `STZhongsong.ttf` | 华文中宋 STZhongsong | Changzhou SinoType Technology Co., Ltd. 1991–1998 | `0x0008` Editable | ❌ **不建议** |

**为什么 `fsType = Editable` 仍不能分发？** `fsType` 描述的是「字体文件被嵌入 PDF 等文档时的权限」，**不是**「字体文件本身的再分发授权」。中易字体的授权文本明确限定：字体仅随「包含该字体的产品」使用，允许（i）以嵌入方式用于显示和打印内容，（ii）临时下载到打印机等输出设备——**未授予复制并公开分发的权利**。华文系列字体同样只声明了著作权归属，未授予再分发权。

> 这些文件已移入本地留档目录 `filedeleted/`，并被 `.gitignore` 排除，**不会**随仓库上传。详见该目录下的 `README.md`。

### 9.2 替换对照表（当前生效）

| 原商业字体 | 现用开源字体 | 文件 | 授权 | 下载来源 |
|---|---|---|---|---|
| 宋体 SimSun | 思源宋体 Source Han Serif SC | `SourceHanSerifSC-Regular.otf` / `-Bold.otf` | SIL OFL 1.1 | [adobe-fonts/source-han-serif](https://github.com/adobe-fonts/source-han-serif) |
| 黑体 SimHei | 思源黑体 Source Han Sans SC | `SourceHanSansSC-Regular.otf` / `-Bold.otf` | SIL OFL 1.1 | [adobe-fonts/source-han-sans](https://github.com/adobe-fonts/source-han-sans) |
| 楷体 SimKai | 霞鹜文楷 LXGW WenKai | `LXGWWenKai-Regular.ttf` | SIL OFL 1.1 | [lxgw/LxgwWenKai](https://github.com/lxgw/LxgwWenKai) |
| 仿宋 SimFang | Fandol 仿宋 | `FandolFang-Regular.otf` | GPL v3 + font exception | [CTAN: fandol](https://ctan.org/pkg/fandol) |
| 隶书 LiSu | 霞鹜文楷 Light | `LXGWWenKai-Light.ttf` | SIL OFL 1.1 | [lxgw/LxgwWenKai](https://github.com/lxgw/LxgwWenKai) |
| 华文新魏 STXinwei | 霞鹜文楷 Light | `LXGWWenKai-Light.ttf` | SIL OFL 1.1 | 同上 |
| 华文中宋 STZhongsong | 思源宋体 Bold | `SourceHanSerifSC-Bold.otf` | SIL OFL 1.1 | 同上 |

西文与数学字体（TeX Gyre Termes / Heros / Cursor、STIX Two Math）原本即为开源授权，**保持不变**。

授权全文存放于 `fonts/LICENSES/`：

| 文件 | 对应字体 | 授权 |
|---|---|---|
| `fonts/LICENSES/SourceHanSerif-Sans-OFL-1.1.txt` | 思源宋体 / 思源黑体 | SIL OFL 1.1 |
| `fonts/LICENSES/LXGWWenKai-OFL-1.1.txt` | 霞鹜文楷 | SIL OFL 1.1 |
| `fonts/LICENSES/Fandol-GPLv3-with-font-exception.txt` | Fandol 仿宋 | GPL v3 + font exception |

### 9.3 手工复现下载与替换

如需重新获取字体文件，可按下列命令下载（均为官方发布地址）：

```bash
mkdir -p fonts && cd fonts

# 思源宋体 / 思源黑体（SIL OFL 1.1）
curl -LO https://raw.githubusercontent.com/adobe-fonts/source-han-serif/release/OTF/SimplifiedChinese/SourceHanSerifSC-Regular.otf
curl -LO https://raw.githubusercontent.com/adobe-fonts/source-han-serif/release/OTF/SimplifiedChinese/SourceHanSerifSC-Bold.otf
curl -LO https://raw.githubusercontent.com/adobe-fonts/source-han-sans/release/OTF/SimplifiedChinese/SourceHanSansSC-Regular.otf
curl -LO https://raw.githubusercontent.com/adobe-fonts/source-han-sans/release/OTF/SimplifiedChinese/SourceHanSansSC-Bold.otf

# 霞鹜文楷（SIL OFL 1.1）
curl -LO https://github.com/lxgw/LxgwWenKai/releases/latest/download/LXGWWenKai-Regular.ttf
curl -LO https://github.com/lxgw/LxgwWenKai/releases/latest/download/LXGWWenKai-Light.ttf

# Fandol 仿宋（GPL v3 + font exception），从 CTAN 打包中取出
curl -LO https://mirrors.tuna.tsinghua.edu.cn/CTAN/fonts/fandol.zip
unzip -j fandol.zip 'fandol/FandolFang-Regular.otf' 'fandol/COPYING' -d .
mv COPYING LICENSES/Fandol-GPLv3-with-font-exception.txt
```

改用其他开源中文字体时，只需修改 `gmcm.cls` 中 `\setCJKmainfont` / `\setCJKsansfont` / `\setCJKmonofont` 与各 `\setCJKfamilyfont` 指定的文件名，其余命令（`\songti`、`\heiti`…）保持不变即可。

### 9.4 重新启用其他字体的注意事项

若你出于比赛排版要求需要恢复某款商业字体（例如必须与官方 Word 模板完全一致的宋体/黑体字形），请注意：

- **本地使用**（编译自己论文、提交成品 PDF 给组委会）属于字体授权允许的「嵌入用于显示和打印」情形，通常无碍；
- **公开分发字体文件**（放进公开仓库、网盘、模板售卖页）**不被授权允许**，可能引发侵权主张或 DMCA 下架；
- 若确需在论文中使用这些字形但又不分发字体文件，可只提交**编译好的 PDF**（内嵌字体），不要把 `.ttf/.ttc/.otf` 一并提交；
- 公开仓库请保持使用本项目的开源字体方案。

### 9.5 已执行的 Git 历史清理（已完成）

本仓库在替换字体之前曾把商业字体提交过一次（提交 `264ae24`），**仅删除最新版本中的文件是不够的**——旧提交里仍能检出字体文件。
本项目已用 `git filter-repo` 完成历史改写：

```bash
# 1) 安装（本次使用 uv；亦可用 pip install git-filter-repo）
uv tool install git-filter-repo

# 2) 从所有历史提交中移除整个 fonts/ 目录
git filter-repo --path fonts --invert-paths --force

# 3) 把换好的开源字体作为一个新提交加入
cp -a /path/to/new_fonts fonts
git add fonts && git commit -m "feat(fonts): add open-source CJK fonts"

# 4) 强制推送覆盖远程
git push --force origin main
```

改写后校验：

```bash
# 历史中不应再出现商业字体
git log --all --oneline --name-only | grep -iE 'SimSun|SimHei|SimKai|SimFang|LiSu|STXinwei|STZhongsong'
# 当前分支中也不应出现
git ls-files | grep -iE 'SimSun|SimHei|SimKai|SimFang|LiSu|STXinwei|STZhongsong'
```

> ⚠ **改写历史会改变所有提交哈希**，协作者需要重新 `git clone`；`filter-repo` 还会移除 `origin` 远程，需手动 `git remote add origin <url>` 恢复。

> ⚠ **已推送到 GitHub 的旧对象可能仍存在于服务器缓存中**。公开仓库如需彻底清除，请：
> 1. 强制推送改写后的历史（使分支上不再可见），并
> 2. 联系 [GitHub Support](https://support.github.com/contact) 请求清除缓存对象；
> 3. 对于新建的、尚无协作者的仓库，最彻底的方式是**删除仓库后重新创建**。

### 9.6 关于提交 PDF 成品

- 本模板编译出的 PDF 会**内嵌**所选字体（`pdffonts build/main.pdf` 可查看内嵌列表）。
- 将 PDF 提交给组委会、或在实验室内部传阅，属于字体授权允许的「嵌入用于显示和打印」场景，通常无碍。
- 本项目默认字体全部为开源授权，因此**公开发布论文 PDF 也没有额外的字体授权顾虑**。
- GitHub 仓库已通过 `.gitignore` 排除 `build/`、`main.pdf` 与 `filedeleted/`，提交前用 `git status` 再确认一次。

### 9.7 免责声明

- 上述版权信息来源于字体文件内部的 `name` / `OS/2` 表，可能与厂商最新公布的条款存在出入。
- 字体厂商可能更新授权条款、更名或停止分发，本节内容无法自动同步，请以官方最新声明为准。
- 商业字体在**中国大陆**的著作权由中易电子（宋体/黑体/楷体/仿宋）与相关厂商（华文系列、隶书）持有；不同地区的版权状态和合理使用边界可能不同。
- 本模板作者不对因字体授权问题产生的纠纷承担责任；是否使用、如何使用，请使用者自行评估并负责。

## 10. 格式规范对照表

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

## 11. AI 工具使用标注

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

## 12. 参考文献格式

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

## 13. 常见问题排查

| 现象 | 原因与解决 |
|---|---|
| `! LaTeX Error: File 'ctex.sty' not found.` | TeX 发行版不完整。安装 `texlive-lang-chinese`、`texlive-latex-extra` |
| `! Font \TU/xxx(0)/m/n not loadable` 或中文全是方框 | 字体文件缺失。确认 `fonts/` 目录完整，且 `\gmcm@fontpath` 指向正确路径 |
| `! Package inputenc Error` / 出现乱码 | 用了 pdfLaTeX。**必须**使用 XeLaTeX |
| `Missing character: There is no … in font` | 字体中没有该字形（如生僻字）。改用 `\heiti`/`\songti`，或换用覆盖更全的字体（思源系列覆盖约 1.6 万汉字） |
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

## 14. 提交前自查清单

### 14.1 内容与格式

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

### 14.2 AI 使用标注（附件 4）

- [ ] AI 生成的模型/公式用 `\aimark{}` 标注，且参考文献中列有对应工具条目
- [ ] AI 生成的数据分析结果前后有 `\ainote{}` 注释，写明名称、版本、机构、日期
- [ ] AI 辅助编写的程序在文件头有注释说明
- [ ] 最终文字为队伍自身表述

### 14.3 隐私与仓库安全

- [ ] `main.tex` 中的 `\school` / `\teamnumber` / `\memberA..C` 仍为占位符
- [ ] `git status` 中不含 `build/`、`*.pdf`、`*.log` 等产物
- [ ] 未提交任何原始数据、密钥、`.env`、题面文件
- [ ] 提交历史中没有被删除但仍可检索到的身份信息
- [ ] 已确认仓库公开 / 私有属性符合预期
- [ ] **若仓库为公开**：`fonts/` 中不含宋体/黑体/楷体/仿宋/隶书/华文新魏/华文中宋等商业字体（本项目默认已全部替换为开源字体，见 [第 9 节](#9-商业字体的替换与合规说明)）
- [ ] `filedeleted/` 未被提交（已由 `.gitignore` 排除）
- [ ] **若商业字体曾进入过 Git 历史**：已用 `git filter-repo` 清理，或已将仓库转为私有

---

## 15. 上传到 GitHub

> 认证方式：**Personal access tokens (classic)**（HTTPS）。PAT 代替 GitHub 账户密码。

### 15.1 创建 PAT classic

1. GitHub → 头像 → **Settings** → **Developer settings**
2. **Personal access tokens → Tokens (classic)** → **Generate new token (classic)**
3. 设置名称与**到期时间**（不要选永久有效）
4. 勾选权限：推送到私有仓库需 **`repo`**；只推公开仓库 **`public_repo`** 即可
5. 生成后**立即复制**（只显示一次）。若仓库属于启用了 SSO 的组织，还需点 **Configure SSO** 授权

> 令牌等同于账户密码，切勿写进脚本、远程地址或提交记录。

### 15.2 初始化并推送

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

### 15.3 后续更新

```bash
git add .
git commit -m "描述本次修改"
git push
```

### 15.4 常见问题

| 现象 | 说明 |
|---|---|
| `remote: Password authentication is not supported` | 输成了账户密码，应使用 PAT |
| `403 Permission denied` | PAT 缺 `repo`/`public_repo` 权限、已过期，或仓库所有者不对；组织仓库还要检查 SSO 授权 |
| `refusing to merge unrelated histories` | GitHub 仓库创建时勾选了 README 等初始文件。本地先 `git pull origin main --allow-unrelated-histories` 合并，**不要**直接强推 |
| `src refspec ... does not match any` | 尚无提交，或分支名不符。先确认 `git status`、`git branch --show-current` |
| 每次都要重新输入令牌 | 可配置 Git Credential Manager / GitHub CLI 等凭据管理器；**不要**用明文存储的方式 |

---

## 16. 许可与致谢

- **模板代码**（`gmcm.cls`、`main.tex`、`sections/`、`code/`、`README.md`）：可自由修改使用。
- **西文与数学字体**：TeX Gyre 系列为 GUST Font License，STIX Two Math 为 SIL Open Font License 1.1，均可自由使用与再分发。
- **中文字体**：思源宋体 / 思源黑体（`SIL OFL 1.1`）、霞鹜文楷（`SIL OFL 1.1`）、Fandol 仿宋（`GPL v3 + font exception`），**均为开源字体，可自由使用与再分发**；授权全文见 `fonts/LICENSES/`。原模板使用的宋体/黑体/楷体/仿宋/隶书/华文新魏/华文中宋等商业字体已全部移除，替换说明见 [第 9 节 商业字体的替换与合规说明](#9-商业字体的替换与合规说明)。
- **封面 logo**：中国研究生创新实践系列大赛 / 学位与研究生教育学会 / 华为 / 西安交通大学等标识归各自权利人所有，仅用于竞赛论文版式，请遵守各自的使用规范。
- 本模板依据官方附件 2 / 3 / 4 整理，最终格式请以官方发布的最新文件为准。
- 本仓库仅供学习与竞赛写作使用，字体与标识的合规性由使用者自行负责（详见 9.7 免责声明）。
