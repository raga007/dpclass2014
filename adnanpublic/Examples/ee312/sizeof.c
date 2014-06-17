#include <stdio.h>

void main(void) {
  int A[10];
  printf("sizeof char = %lu\n", sizeof(char) );
  printf("sizeof short = %lu\n", sizeof(short) );
  printf("sizeof int = %lu\n", sizeof(int) );
  printf("sizeof long = %lu\n", sizeof(long) );
  printf("sizeof long long = %lu\n", sizeof(long long) );
  printf("sizeof float = %lu\n", sizeof(float) );
  printf("sizeof double = %lu\n", sizeof(double) );
  printf("sizeof void * = %lu\n", sizeof(void *) );
  printf("sizeof array = %lu\n", sizeof(A));
}
