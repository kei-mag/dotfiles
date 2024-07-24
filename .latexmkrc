#!/usr/bin/env perl

# file: LaTeXMK の設定ファイル
# author: Keisuke Magara
# created: 2022-04-13
# last modified: 2023-04-16


# 通常の LaTeX ドキュメントのビルドコマンド
$latex = 'uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -file-line-error -interaction=nonstopmode %S';
# $latex = 'platex %O -synctex=1 %S';

# LuaLaTeX のビルドコマンド
$lualatex = 'lualatex %O -synctex=1 -file-line-error -interaction=nonstopmode %S';

# pdfLaTeX のビルドコマンド
$pdflatex = 'pdflatex %O -synctex=1 -file-line-error -interaction=nonstopmode %S';

# XeLaTeX のビルドコマンド
$xelatex = 'xelatex %O -no-pdf -synctex=1 -shell-escape -file-line-error -interaction=nonstopmode %S';

# Biber, BibTeX のビルドコマンド
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
# $bibtex = 'pbibtex %O %S';

# makeindex のビルドコマンド
$makeindex = 'upmendex %O -o %D %S';
# $makeindex = 'mendex %O -o %D %S';

# dvipdf のビルドコマンド
$dvipdf = 'dvipdfmx %O -o %D %S';

# dvipd のビルドコマンド
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';

# PDF の作成方法を指定するオプション
## $pdf_mode = 0; PDF を作成しない。
## $pdf_mode = 1; $pdflatex を利用して PDF を作成。
## $pdf_mode = 2; $ps2pdf を利用して .ps ファイルから PDF を作成。
## pdf_mode = 3; $dvipdf を利用して .dvi ファイルから PDF を作成。
## $pdf_mode = 4; $lualatex を利用して .dvi ファイルから PDF を作成。
## $pdf_mode = 5; xdvipdfmx を利用して .xdv ファイルから PDF を作成。
$pdf_mode = 3;


# LaTeXMKの設定
$max_repeat = 5;  # 最大繰り返し回数
# latexmkを-pvcオプションをつけて実行すると、texファイルに変更があるたびに自動で再コンパイルする。
# その際に、昔のデータをいくつ残しておくかを指定する（0だと残さない）
$pvc_view_file_via_temporary = 0;

# PDF viewer の設定
if ($^O eq 'linux') {  # Linux
    $dvi_previewer = "xdg-open %S";
    $pdf_previewer = "xdg-open %S";
} elsif ($^O eq 'darwin') {  # Mac OS
    $dvi_previewer = "open %S";
    $pdf_previewer = "open %S";
} else {  # Windows
    $dvi_previewer = "start %S";  # .dvi に関連付けられた既存のソフトウェアで表示する。
    $pdf_previewer = "start %S";  # .pdf に関連付けられた既存のソフトウェアで表示する。
    # $pdf_previewer = 'SumatraPDF -reuse-instance';
}
## Windows では SyncTeX(PDF をビューアーで開いたまま中身の更新が可能で更新がビューアーで反映される機能) が利用できる SumatraPDF 等が便利。
## SumatraPDF: https://www.sumatrapdfreader.org/free-pdf-reader.html