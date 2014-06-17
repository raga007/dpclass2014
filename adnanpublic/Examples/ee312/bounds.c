#include <stdio.h>

#include <stdlib.h>

int main(void) {

  int A[3] = {1,2,3};

  int i;

  for ( i = 0 ; i <= 3; i++ ) {

    printf("A[%d] = %d\n", i, A[i] );

  }

  int *B = (int *) malloc(sizeof(int)*3);

  for ( i = 0 ; i <= 3; i++ ) {

    printf("B[%d] = %d\n", i, B[i] );

  }

  return 0;

}
