#include <stdio.h>

struct address {
  char *name;
  int number;
};

struct node {
  int age;
  struct address ad;
};


int main(void) {
  struct node n;
  n.ad.number = 12;
  printf("%d\n", n.ad.number);
  return 0;
}
