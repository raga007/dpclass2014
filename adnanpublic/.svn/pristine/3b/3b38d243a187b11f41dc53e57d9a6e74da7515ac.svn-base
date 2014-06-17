#include <stdio.h>

char a[] = "adnan";
char b[] = "aziz";
char c[] = "gordon";
char d[] = "gecko";

void multiret( int type, char** x, char* y[]) {
  if ( type == 0 ) {
    *x = a;
    *y = b;
  } else if ( type == 1 ) {
    *x = c;
    *y = d;
  } else {
    *x = NULL;
    *y = NULL;
  }
  return;
} 

int main(void) {
  char* first="barack";
  char* last="obama";
  multiret( 0, & first, & last );
  printf("%s,%s\n", first, last);
  multiret( 1, & first, & last );
  printf("%s,%s\n", first, last);
  return 0;
}

