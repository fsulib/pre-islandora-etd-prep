#!/bin/sh

INPUT=$1
OUTPUT=`echo coverpage.${1} | sed "s/.xml/.pdf/"`

java -jar ./saxon9he.jar -o:${1}.fo $INPUT mods2fo.xsl
fop-1.1/fop ${1}.fo $OUTPUT
#rm ${1}.fo
