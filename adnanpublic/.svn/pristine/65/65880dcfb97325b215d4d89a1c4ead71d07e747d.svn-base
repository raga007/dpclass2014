#!/bin/bash

function onecheck {
  RESULT=`echo $1 $2| ./calculator add`
  #echo "RESULT = " $RESULT
  GREPRESULT=`echo $RESULT| grep $3`
  if [ $RESULT -eq 2 ] ; then
    score=`expr $score + 10`
  fi 
}

function checkargs {
  onecheck "1" "4.5" "5.6"
  onecheck "2" "14" "6"
  onecheck "3" "4.5" "5.6"
  RESULT=`echo 1 1 | ./calculator add`
  echo "RESULT = " $RESULT
  if [ $RESULT -eq 2 ] ; then
    score=`expr $score + 10`
  fi 
  RESULT=`echo 3 4 | ./calculator multiply`
  echo "RESULT = " $RESULT
  if [ $RESULT -eq 12 ] ; then
    score=`expr $score + 10`
  fi 
  echo "score = " $score
}

function check {
  cd $1;
  raw_eid_from_dirname=$1;
  # assuming directory name is assign0_rd51_attempt_1
  # use the @ subs to  mark off the _, otherwise sed will remove too much
  eid_from_dirname=`echo $raw_eid_from_dirname | sed 's/_/@/' | sed 's/.*@//g' | sed 's/_/@/' | sed 's/@.*//g'`
  echo "eid_from_dirname = " $eid_from_dirname

  score=0
  #echo "PWD = " `pwd`

  # extracting EID from file itself
  raweid=`cat calculator.c | grep EID`
  #echo "raw eid = " $raweid
  eid=`echo $raweid | sed 's/.*EID://g'`
  #echo "eid = " $eid
  if [ -z "$eid" ] ; then 
    comment="missing eid "
  fi 
  rm -f calculator 
  noexec=0
  gcc -o calculator calculator.c >& /dev/null
  # echo "RETVAL FROM GCC = " $?
  if [ $? != 0 ] ; then
    #echo "failed compile"
    noexec=1
    comment=$comment":compile fail"
  fi
  if [ "$noexec" = "0" ] ; then
    #echo "calling checkargs"
    checkargs
  fi 
  echo $eid","$score","$comment
  eid=""
  comment=""
  score=""
  cd ..
}

LIST=`ls -r $1`

cd $1
#echo $LIST
for i in $LIST 
do
  #echo "#i = " $i
  #echo "pwd = " `pwd`
  check $i
done
