#include <stdio.h>

int main(void) {
  int i, j;
  // int A[][] = { {1,2,3}, {4,5,6}, {7,8,9} };
  int A[2][3] = { {1,2}, {4,5,6}, {7,8} };
  for ( i = 0 ; i < sizeof(A)/sizeof(A[0]); i++ ) {
    for ( j = 0 ; j < sizeof(A[0])/sizeof(int); j++ ) {
      printf("A[%d][%d] = %d ", i, j, A[i][j] );
    }
    printf("\n");
  }
  return 0;
}
