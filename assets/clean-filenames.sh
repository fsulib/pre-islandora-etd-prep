#!/bin/sh

# Changes all files in $1 with .mods to .xml
# $1 is a directory of files

for f in $( ls $1/*.mods 2>/dev/null ); do
  mv $f $( echo $f | sed "s/.mods/.xml/" )
done

for f in $( ls $1/*.metadata.xml 2>/dev/null ); do
  mv $f $( echo $f | sed "s/.metadata//" )
done

for f in $( ls $1/*.fulltext.pdf 2>/dev/null ); do
  mv $f $( echo $f | sed "s/.fulltext//" )
done


