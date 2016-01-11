#!/bin/sh

# Requires GhostScript
# $1 is coverpage file name
# $2 is main document file name
# $3 is output file name

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=$3 $1 $2
#pdftk $1 $2 cat output $3
