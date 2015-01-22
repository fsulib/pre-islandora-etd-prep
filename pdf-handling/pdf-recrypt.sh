#!/bin/sh

# Requires:
# - pdftk (PDF Tool Kit)

rm -r resecured/
mkdir resecured/

pdftk desecured/$1 output resecured/$1 owner_pw g0N0l3Z
