#!/bin/sh

# Wrapper for subscripts
# $1 is a directory of records to be cleaned

# Set batch ID
BID="MIGR"

# Test to make sure an argument has been given
if [ ! ${1} ]; then
  echo "Missing argument 1: input directory"
  exit
fi

SCRIPTROOT=`pwd`
ASSETS=$SCRIPTROOT/assets
INPUTDIR=$SCRIPTROOT/${1%/}
OUTPUTDIR=tmp
FULLOUTPUTDIR=$SCRIPTROOT/tmp
OUTPUTFILE=${INPUTDIR}-batch.zip

if [ ! -d $INPUTDIR  ]; then
  echo "$INPUTDIR does not exist."
  exit
fi

cp -r $INPUTDIR $OUTPUTDIR
sh $ASSETS/clean-filenames.sh $OUTPUTDIR

if [ `xml val --list-bad $OUTPUTDIR/*.xml` ]; then
  printf "\nThe following files are invalid:\n"
  xml val --list-bad $OUTPUTDIR/*.xml
  printf "\nPlease fix before continuing.\n\n"
  exit
fi

for f in $( ls $OUTPUTDIR/*.xml ); do
  sh $ASSETS/clean-prefixes.sh $f
  sh $ASSETS/add-flvc.sh $f $OUTPUTDIR $BID
  #sh $ASSETS/generate-coverpage.sh
done

<<'hey'
cd $OUTPUTDIR
zip -r ${OUTPUTFILE} *
mv ${OUTPUTFILE} ..
cd ..
rm -r $FULLOUTPUTDIR
hey

printf "\nProcess completed, see $OUTPUTFILE.\n\n"
