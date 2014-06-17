#!/bin/sh

# always called with --threshold 1.2M  --ignore .o,.tar
# note: the order of arguments does matter, i.e., --ignore .o,.tar --threshold 1.2M
# wont work

#THRESHOLD=$2
#IGNORE=$4

# makes use of bash3's =~ and [[ ]] operators. 
# otherwise use return code from grep to perform check
if [[ $1 =~ "--threshold" ]] ; then
 THRESHOLD=$2
 if [[ $3 =~ "--ignore" ]] ; then 
   IGNORE=$4
   if [[ $= =~ "" ]] ; then
     echo "incorrect usage"
     INCORRECTUSAGE="true"
   fi
 else # matches the case where there's no ignore, so we use "" for the ignore string
   IGNORE=""
 fi 
else # matches if [[ $1 =~ "--threshold" ]]
  INCORRECTUSAGE="true"
fi

if [[ $INCORRECTUSAGE =~ "true" ]] ; then
   echo "incorrect usage: need to be called as\n --threshold 1.2M  --ignore .o,.tar"
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
  DATA=`ls -lrt $FILENAME | awk '{print $5 " " $9}'`
  # >> will append to the file
  echo $DATA >> /tmp/unsortedlist.txt
done
# heavy lifting is done in the threshold program
cat /tmp/unsortedlist.txt | ./threshold $THRESHOLD $IGNORE
