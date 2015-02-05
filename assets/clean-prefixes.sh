#!/bin/sh

# Replaces <mods:element> with <element>
# $1 should be a single file

perl -pi -e 's/mods://g' $1
