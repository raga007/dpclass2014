/*
  # 2
  # 4.5
  # 7.8
  #RESULT=`echo "3 \n 4.5" | ./calculator`
  #GREPRESULT=`echo $RESULT| grep 5.6`
  #if [ -z "$GREPRESULT" ] ; then
  #  echo "FAIL"
  #else
  #  echo "PASS"
  #fi
  */
#include <stdio.h>
int main() {
  char inputmode[1024];
  char inputdata[1024];
  char outputdata[1024];

  while ( NULL != gets(inputmode) ) {
    gets(inputdata);
    gets(outputdata);
    printf("RESULT = `echo \"%s \\n %s | ./calculator`\n"
          "GREPRESULT=`echo $RESULT| grep %s`\n"
          "if [ -z \"$GREPRESULT\" ] ; then\n"
          "echo \"FAIL\"\n"
          "else\n"
          "  echo \"PASS\"\n"
          "fi", inputmode, inputdata, outputdata );
  }
}
