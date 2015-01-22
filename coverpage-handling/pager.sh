#!/usr/bin/env bash

INPUT=testinput.xml
OUTPUT=testoutput.pdf

java -jar saxon9he.jar -o:testintermediate.fo $INPUT bepress2fo-modified.xsl
fop-1.1/fop testintermediate.fo $OUTPUT
