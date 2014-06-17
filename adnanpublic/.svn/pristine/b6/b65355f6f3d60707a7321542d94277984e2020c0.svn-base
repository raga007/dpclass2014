#include <stdio.h>

int computefactorial( int n ) {
  if ( n == 0 ) {
    return 1;
  } else {
    return n * computefactorial(n -1);
  }
}

int main(int argc, char**argv){
  int n = -1;
  int factorial = 1;
  printf("Enter a number\n");
  scanf("%d", & n );
  printf("You entered %d\n", n);
  if ( n >= 0 ) {
    factorial = computefactorial(n);
    printf("The factorial of %d is %d\n", n, factorial );
  } else {
    printf("You entered a negative number: %d\n", n );
  }
  return 0;
}


