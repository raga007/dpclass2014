#include <stdio.h>

#define ODD(n) ((n)%2 != 0)

#define N 1000000000

inline long odd(long n) {
  return n%2 != 0;
}

int main(void) {
  long i;
  long tmp = 0;
  for (i = 0; i < N; i++ ) {
    tmp += odd(i);
  }
  printf("tmp = %ld\n", tmp);
  return 0;
}
