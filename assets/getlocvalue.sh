#!/bin/sh

# Usage: ./getlocvalue.sh type/URI
# where 'type' is either 'names' for name authorities 
# or 'subjects' for subject authorities
# and 'URI' is the individual URI ID.
# For example, the authority URI for Diane W. Hodgins is http://id.loc.gov/authorities/names/no2007085308
# If you already have this URI and want to know what it goes to, run the script as:
# ./getlocvalue.sh names/no2007085308
# to get the output:
# Hodgins, Diane W. (Diane Weaver)

curl -sI http://id.loc.gov/authorities/$1 | grep "X-PrefLabel: " | sed 's/X-PrefLabel:\ //'
