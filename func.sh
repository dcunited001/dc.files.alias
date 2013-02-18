#!/bin/bash
# shell functions for all platforms

#===============================
# Awk Functions
#===============================
# Examples
# - http://awk.info/?EdM
# - http://awk.info/?awk1line
# - http://www.grymoire.com/Unix/Awk.html#uh-4
# - http://www.ibm.com/developerworks/library/l-awk1/

awk-insert-above(){
  file=$1; rgx=$2; str=$3;
  script="{ print (/$rgx/ ? \"$str\\n\" : \"\") \$0 } "
  awk $script $file; }

awk-insert-below(){
  file=$1; pattern=$2; str=$3;
  script="{ print \$0 (/$rgx/ ? \"\\n$str\" : \"\"); } "
  awk $script $file; }

awk-insert-below-and-replace(){
  filefoo=`get-temp-file awk-insert`;
  awk-insert-below $@[@] > $filefoo;
  cp $file $file.bak; mv $filefoo $file; }

awk-insert-above-and-replace(){
  filefoo=`get-temp-file awk-insert`;
  awk-insert-above $@[@] > $filefoo;
  cp $file $file.bak; mv $filefoo $file; }

#===============================
# Sed Functions
#===============================
  #sed '/regex/{x;p;x;}'    #insert-above
  #sed '/regex/G'           #insert-below
  #sed '/regex/{x;p;x;G;}'  #insert-above-below

#===============================
# Mktemp Functions
#===============================
# hmmm..  probably need bash pointers
#   and seriously? f*** that right now
#copy-thru-temp(){
  #hmmmmm..  what params?  name of function & input array?
#}

get-temp-file(){
  #hmmmm, "thread" safe vars? lol .. YIKES!
  tmpfoo=`basename $1`
  tmpfile=`mktemp /tmp/${tmpfoo}.XXXXXX` || exit 1
  echo $tmpfile
}
