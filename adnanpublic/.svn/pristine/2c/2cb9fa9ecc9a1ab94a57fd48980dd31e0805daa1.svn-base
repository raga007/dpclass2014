#include <stdio.h>

int* bar() {

  int y = 42;

  return &y;

}

void foo() {

  int a[] = {1,2,3};

  printf("%d,%d,%d\n", a[0], a[1], a[2]);

}

int main(void) {

  int* p = bar();

  printf("*p = %d\n", *p);

  foo();

  printf("*p = %d\n", *p);

}

