#!/bin/sh

# Requires:
# - gs (GhostScript)

rm -rf desec
mkdir desec

for f in $( ls $1 ); do
  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=desec/$f -c .setpdfwrite -f $1/$f
  echo $f
done

