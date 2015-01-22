#!/bin/sh

# Requires:
# - gs (GhostScript)
# - pdftk (PDF Tool Kit)

rm -r descured/
mkdir desecured/
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=desecured/$1 -c .setpdfwrite -f $1
