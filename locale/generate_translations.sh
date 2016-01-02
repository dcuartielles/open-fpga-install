#!/bin/bash
##
# Generate binary translation files to be used by the installation script
# array for the available translation files, the array shoud look as follows
# - files=(en es)
# but we want that array to be automatically generated given all of the *.po
# files in a "translations" folder, making easier to contribute to the project
# by just translating the original *.po file

# verbose level
verbose=0

# create a files array taking all of the *.po files starting in the
# current folder and looking recusively
files=($(find . -type f -regex "^.*po"))

# extract the extension and the base path to the file and work from there
for item in ${files[*]}
do
  filename=$(basename "$item")
  extension="${filename##*.}"
  filename="${filename%.*}"
  if [ $verbose -eq 1 ]
    then printf "   %s\n" $filename
  fi

  # delete previous existing folders with that translation
  rm -fR $filename

  # make sure there is a folder where to move stuff
  mkdir $filename
  mkdir $filename/LC_MESSAGES

  # create the specific translation file for the language
  msgfmt -o install.sh.mo ${item}

  # move the file to the right folder
  mv install.sh.mo $filename/LC_MESSAGES/
done


#for i in ${translations[@]}; do
#
#
#
#
#  echo ${i}
#done
