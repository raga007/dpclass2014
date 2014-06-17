#!/bin/sh

# always called with --threshold 1.2M  --care .o,.tar
# note: the order of arguments does matter, i.e., --care .o,.tar --threshold 1.2M
# wont work

#THRESHOLD=$2
#IGNORE=$4

# makes use of bash3's =~ and [[ ]] operators. 
# otherwise use return code from grep to perform check
if [[ $1 =~ "--threshold" ]] ; then
 THRESHOLD=$2
 if [[ $3 =~ "--care" ]] ; then 
   IGNORE=$4
   if [[ $= =~ "" ]] ; then
     echo "incorrect usage"
     INCORRECTUSAGE="true"
   fi
 else # matches the case where there's no ignore, so we use "" for the ignore string
   IGNORE=""
 fi 
else # matches if [[ $1 =~ "--care" ]]
  INCORRECTUSAGE="true"
fi

if [[ $INCORRECTUSAGE =~ "true" ]] ; then
   echo "incorrect usage: need to be called as\n --threshold 1.2M  --care .o,.tar"
   exit -1
fi

LIST=`find . -type f`
# we'll store the files in /tmp/unsortedlistlist.txt
# the next line clobbers /tmp/unsortedlistlist.txt, if
# it exists
echo "" > /tmp/unsortedlist.txt
for FILENAME in $LIST 
do
  # unfortunately, the -b option to du only works on Linux, not on Mac
  # DATA=`du -b $FILENAME`
  # DATA=`ls -lrt $FILENAME | awk '{print $5 " " $9}'`
  CHECKSUM=`md5 $FILENAME | awk '{print $4 " " $2}'  | sed 's/(//' | sed 's/)//'`
  # >> will append to the file
  echo $CHECKSUM
  echo $CHECKSUM >> /tmp/unsortedlist.txt
done
# heavy lifting is done in the threshold program
cat /tmp/unsortedlist.txt | sort > /tmp/sortedlist.txt
SORTEDLIST=`cat /tmp/sortedlist.txt`
echo $SORTEDLIST
