#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 128

extern long parsetime(char *, char *);

char *getcol( char *line, int id ) {
  int length = strlen( line );
  char *start = NULL;
  int numfields = 0;
  int i;
  for ( i = 0 ; i < length; i++ ) {
     if ( line[i] == '|' ) {
        numfields++;
     }
     if ( numfields == id ) {
       start = line + i + 1;
       while ( line[++i] != '|' );
       line[i] = '\0';
       // printf("start = %s\n", start );
       return start;
     }
  }
  return NULL;
}

int main() {
  char tmpbuf[N];
  char *remove;
  long sum = 0;
  FILE *tick = stdin; // fopen("tick.dat", "r" );

  while ( fgets(tmpbuf, N, tick)  != NULL ) {
    // char *remove = strdup( tmpbuf );
    char type = tmpbuf[0];
    if ( type == 't' ) {
      char *volume = getcol( tmpbuf, 5 );
      char *price = getcol( tmpbuf, 4 );
      char *symbol = getcol( tmpbuf, 3 );
      char *time = getcol( tmpbuf, 2 );
      char *date = getcol( tmpbuf, 1 );
      long datetime = parsetime( time, date );
      printf("%ld:%s:%s:%s\n", datetime, symbol, price, volume );
    }
  }
  fclose(tick);
  return 0;
}
