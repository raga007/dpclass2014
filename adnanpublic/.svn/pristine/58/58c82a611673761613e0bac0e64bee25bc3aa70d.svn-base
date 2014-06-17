#include <stdio.h>

#include <stdlib.h>

int main(void) {

  int *A = (int *) malloc(3*sizeof(int));

  int *B = (int *) malloc(3*sizeof(int));

  A[0] = A[1] = 42;

  B[0] = B[1] = B[2] = 17;

  printf("A[2] = %d\n", A[2]);

  free(A);

  printf("A[0] = %d\n", A[0]);

  printf("B[0] = %d\n", B[0]);

  return 0;

}
