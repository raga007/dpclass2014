#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BUFSIZE 1024
#define NUM_IGNORE 128

extern long normalized_file_size( char *filesize );
extern int check_do_ignore( char *ignorelist, char *filename );
extern int check_suffix( char *s, char *t );

// call as threshold cutoff [ignorefiles]
// (Unix convention is arguments in square brackets are optional)
// on input, each line is of the form
// thisfilesize thisfilename
int main(int argc, char **argv) {
  char tmpbuf[BUFSIZE];
  if ( argc < 2 ) {
    fprintf(stderr, "bad call to threshold, needs to be of the form:\n"
                    "\tthreshold cutoff [ignorefiles>]n");
  }
  long cutoff = normalized_file_size(argv[1]);
  char *ignore_list_argument;
  if ( argc == 3 ) {
    ignore_list_argument = argv[2];
  } else {
    ignore_list_argument = "";
  }
  long thisfilesize;
  char thisfilename[BUFSIZE];
  while ( NULL != fgets(tmpbuf, BUFSIZE, stdin ) ) {
    int numread = sscanf(tmpbuf, "%ld%s", & thisfilesize, thisfilename );
    if ( numread == 2 
             && thisfilesize > cutoff 
             && !check_do_ignore( ignore_list_argument, thisfilename ) ) {
      printf("%s\n", thisfilename);
    }
  }
  return 0;
}

// file sizes specification formats:
//   1200
//   13.5K
//   77M
//   1.45G
long normalized_file_size( char *filesize ) {
  int length = strlen(filesize);
  int multiplier = 0;
  if ( filesize[length-1] == 'K' ) {
    multiplier = 1024;
  }
  if ( filesize[length-1] == 'M' ) {
    multiplier = 1024*1024;
  }
  if ( filesize[length-1] == 'G' ) {
    multiplier = 1024*1024*1024;
  }
  // check if it ends in K M or G
  if ( multiplier != 0 ) {
    filesize[length-1] = '\0';
    return multiplier * atof(filesize);
  }
  return atol(filesize);
}

// ignore_list is specified as ".o,.tar"
int check_do_ignore( char *ignore_list_argument, char *filename ) {
  if ( strlen(ignore_list_argument) == 0 ) {
    // no files are to be ignored
    return 0;
  }
  char *ignore_suffixes[NUM_IGNORE];
  int i = 0;
  // need to duplicate ignore_list_argument since strtok calls
  // will clobber its argument, see man page:
  // http://www.cplusplus.com/reference/cstring/strtok/
  char *ignore_list_argument_dup = strdup( ignore_list_argument );
  ignore_suffixes[i] = strtok( ignore_list_argument_dup, "," );
  while ( (ignore_suffixes[++i] = strtok( NULL, "," )) != NULL ); 
  int j;
  for ( j = 0 ; j < i; j++ ) {
    if ( check_suffix( filename, ignore_suffixes[j] ) ) {
      return 1;
    }
  }
  return 0;
}

// check if t is a suffix of s
int check_suffix( char *s, char *t ) {
  int strlen_s = strlen( s ) ;
  int strlen_t = strlen( t ) ;
  if ( strlen_s < strlen_t ) {
    return 0;
  }
  int j;
  for ( j = 0 ; j < strlen_t; j++ ) {
    if ( s[ strlen_s - 1 - j ] != t[strlen_t - 1 - j] ) {
      return 0;
    }
  }
  return 1;
}
