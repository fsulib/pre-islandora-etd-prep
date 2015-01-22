#!/bin/sh

# Set batch ID
BID="MIGR"

# Wrapper for subscripts
# $1 is a directory of records to be cleaned
# $2 is the name of the output directory

# Test to make sure an argument has been given
if [ ! ${1} ]; then
  echo "Missing arguments 1 and 2."
  echo "\$1 is input directory name"
  echo "\$2 is output directory name"
  exit
fi

INPUTDIR=$1
OUTPUTDIR=tmp
if [ ! -d $INPUTDIR  ]; then
  echo "$INPUTDIR does not exist."
  exit
fi

cp -r $INPUTDIR $OUTPUTDIR

sh components/clean-filenames.sh $OUTPUTDIR

if [ `xml val --list-bad $OUTPUTDIR/*.xml` ]; then
  printf "\nThe following files are invalid:\n"
  xml val --list-bad $OUTPUTDIR/*.xml
  printf "\nPlease fix before continuing.\n\n"
  exit
fi

for f in $( ls $OUTPUTDIR/*.xml ); do
  sh components/clean-prefixes.sh $f
  sh components/add-flvc.sh $f $OUTPUTDIR "MIGR"
done

zip ${INPUTDIR}_batch.zip $OUTPUTDIR

printf "\nFinished.\nCheck $OUTPUTDIR for all freshly modified files.\n\n"
