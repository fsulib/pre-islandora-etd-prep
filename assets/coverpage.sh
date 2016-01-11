#!/bin/sh

INFILE=`basename ${1}`
OUTFILE=`echo coverpage.${INFILE} | sed "s/.xml/.pdf/"`

python3 assets/metapull.py $1 $2 $OUTFILE

#java -jar assets/saxon9he.jar -o:${2}/${OUTFILE}.fo ${1} assets/mods2fo.xsl

assets/fop-1.1/fop ${2}/${OUTFILE}.fo ${2}/$OUTFILE > /dev/null 2>&1
rm ${2}/${OUTFILE}.fo
