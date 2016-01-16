#!/bin/bash


xmlstarlet ed -L -i //mods -t attr -n xmlns -v http://www.loc.gov/mods/v3 $1
xmlstarlet ed -L -i //_:mods -t attr -n xmlns:xsi -v http://www.w3.org/2001/XMLSchema-instance $1
xmlstarlet ed -L -i //_:mods -t attr -n xmlns:xlink -v http://www.w3.org/1999/xlink $1
xmlstarlet ed -L -i //_:mods -t attr -n xmlns:mods -v http://www.loc.gov/mods/v3 $1
xmlstarlet ed -L -i //_:mods -t attr -n xmlns:dcterms -v http://purl.org/dc/terms/ $1
xmlstarlet ed -L -i //_:mods -t attr -n xmlns:etd -v http://www.ndltd.org/standards/metadata/etdms/1.0/ $1

# fix weird space between URLs in line below
xmlstarlet ed -L -i //_:mods -t attr -n xsi:schemaLocation -v "http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd" $1

xmlstarlet ed -L -i //_:mods -t attr -n version -v 3.4 $1

perl -pi -e 's/<mods/<mods:mods/g' $1
perl -pi -e 's/<\/mods>/<\/mods:mods>/g' $1
