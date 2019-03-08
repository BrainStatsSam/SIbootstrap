#!/bin/bash

#Convert .tif images to .pdfs in the tiffImages folder

rm *.pdf  #Note this is to remove the existing .pdfs which we want to replace probably unnecessary in general.

find ./ -iname "*.tif" -exec convert {} {}.pdf \;

mmv \*.tif.pdf \#1.pdf
