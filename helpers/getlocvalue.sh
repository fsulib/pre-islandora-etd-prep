#!/bin/sh

# Usage: ./getlocvalue.sh URI
# For example, the authority URI for Diane W. Hodgins is http://id.loc.gov/authorities/names/no2007085308
# If you already have this URI and want to know what it goes to, run the script as:
# ./getlocvalue.sh http://id.loc.gov/authorities/names/no2007085308
# to get the output:
# Hodgins, Diane W. (Diane Weaver)

URI=$1
VAL=`curl -sI ${URI} | grep "X-PrefLabel: " | sed 's/X-PrefLabel:\ //' | tr -d '\r'`
echo "'${URI}', '${VAL}'"
