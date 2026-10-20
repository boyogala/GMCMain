# latexmk 配置：XeLaTeX 编译，产物统一输出到 build/
# 用法：latexmk -xelatex main.tex
$pdf_mode    = 5;                                                     # 直接生成 PDF
$xelatex    = 'xelatex -no-shell-escape -interaction=nonstopmode -file-line-error %O %S';
$max_repeat = 3;                                                     # 交叉引用/目录稳定所需的重复编译次数
$out_dir    = 'build';                                                # PDF 与中间文件输出目录
