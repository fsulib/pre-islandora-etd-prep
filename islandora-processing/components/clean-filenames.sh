#!/bin/sh

# Changes all files in $1 with .mods to .xml
# $1 is a directory of files

for f in $( ls $1/*.mods ); do
  mv $f $( echo $f | sed "s/mods/xml/" )
done


