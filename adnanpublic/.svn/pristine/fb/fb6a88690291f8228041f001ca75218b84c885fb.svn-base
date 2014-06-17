#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// EID:rd51

int mode = -1; // 0 == plus, 1 == mult

extern void processlines();
extern void processline(char *);

bad text for missing compile

int main(int argc, char **argv) {
  if ( !usage(argc, argv) ) {
    printf("Usage: calculator [add|multiply]\n");
    exit (0);
  }
  processlines();
  exit (0);
}

int usage( int argc, char **argv ) {
  if ( argc != 2 ) {
    return 0;
  } 
  if ( !strcmp(argv[1], "add" ) ) {
    mode = 0;
    return 1;
  } else if ( !strcmp(argv[1], "multiply" ) ) {
    mode = 1;
    return 1;
  } else {
    return 0;
  }
}

void processlines() {
  char tmpbuf[1024];
  while ( fgets(tmpbuf, 1024, stdin) != NULL ) {
    processline( tmpbuf );
  }
}

void processline( char *tmpbuf ) {
  char *token = strtok( tmpbuf, " " );
  int result = (mode == 0) ? 0 : 1;
  while ( token != NULL ) {
    if ( mode == 0 ) {
      result += atoi( token );
    } else {
      result *= atoi( token );
    }  
    token = strtok(NULL, " ");
  }
  printf("%d\n", result);
}
