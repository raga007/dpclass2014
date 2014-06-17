#include <stdio.h>
#include <string.h>

#define N 20

int cache[N][N];

int clearcache() {
   for (int i = 0 ; i < N; i++ ) 
     for( int j = 0 ; j < N; j++ ) 
       cache[i][j]  = -1;
   return 0;
}

int min(int x, int y) {
  return ( x < y ? x : y );
}
int count = 0;
int distance( char *s, char *t) {
    int result;
    if ( cache[strlen(s)][strlen(t)] != -1 ) {
      return cache[strlen(s)][strlen(t)];
    }
    count++;
    printf("Called distance with args (%s,%s)\n", s, t );
    if ( strlen( s ) == 0 ) {
      result = strlen( t );
      cache[strlen(s)][strlen(t)] = result;
    } else if ( strlen( t ) == 0 ) {
      result = strlen( s );
      cache[strlen(s)][strlen(t)] = result;
    } else {
      int d1 = distance( s + 1, t );
      int d2 = distance( s, t + 1 );
      int e1 = s[0] - 'a';
      int e2 = t[0] - 'a';
      result = min( e1 + d1, e2 + d2 );
      cache[strlen(s)][strlen(t)] = result;
    }
    return result;
}

int main() {
  char *first = "abcqwefdsdss";
  char *second = "defcvbasdd";
  char *third = "abc";
  clearcache();
  printf("distance between %s and %s is %d\n", 
            first,  second, distance( first, second ) );
  clearcache();
  printf("distance between %s and %s is %d\n", 
            second, third, distance( second, third ) );
}
