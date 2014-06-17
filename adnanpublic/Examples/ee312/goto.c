#include <stdio.h>

int main(void) {
  int i = 0;
  for ( i = 0 ; i < 30; i++ ) {
    if ( i % 13 ) {
      printf("Floor i = %d\n", i);
    } else {
      // continue;
    }
    printf("i mod 4 = %d\n", i % 4 );
  }
  return 0;
}
