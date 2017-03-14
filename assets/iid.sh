#!/bin/bash

# Adds IID to target record
# $1 is target record w/ full path 
# $2 is batch ID

DID=`basename ${1} | sed "s/.xml//"`
xmlstarlet ed -L -s //mods:mods -t elem -n identifier -v FSU_${2}_${DID} $1
perl -pi -e 's/<identifier>/<identifier type="IID">/g' $1
