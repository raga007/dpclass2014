#include <stdio.h>

char raw[1024];

char *my_malloc(int n) {
  char *result = & raw[512];
  int *sizeptr = (int *) (result - sizeof(int));
  *sizeptr = n;
  return result;
}

void printsize(char *p) {
  int *sizeptr = (int *) (p - sizeof(int));
  printf("size of memory allocated that p points to is %d\n", *sizeptr);
}

int main(void) {
  char *p1 = my_malloc(10);
  printsize(p1);
  char *p2 = my_malloc(1024);
  printsize(p2);
  return 0;
}
