#include <stdio.h>

void main() {
  float i = 5;
  int j = i;
  //int j = 2;
  float a = i/2;
  printf("a = %g\n", a );
  a = (float) 5/2;
  printf("a = %g\n", a );
  a = (float) (5/2);
  printf("a = %g\n", a );
  a = ((float) 5 / (float)2);
  printf("a = %g\n", a );
  return 0;
}
