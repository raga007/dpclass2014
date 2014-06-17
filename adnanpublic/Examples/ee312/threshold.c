#include <stdio.h>
#include <string.h>

#define BUFSIZE 1024
#define NUM_IGNORE 128

extern long normalized_file_size( char *filesize );
extern int check_do_ignore( char *ignorelist, char *filename );
extern int check_suffix( char *s, char *t );

// call as threshold [cutoff] [ignorefiles]
// each line is of the form
// [thisfilesize] [thisfilename]
int main(int argc, char **argv) {
  char tmpbuf[BUFSIZE];
  long cutoff = normalized_file_size(argv[1]);
  char *ignore_list_argument = argv[2];
  long thisfilesize;
  char thisfilename[BUFSIZE];
  while ( NULL != fgets(tmpbuf, BUFSIZE, stdin ) ) {
    int numread = sscanf(tmpbuf, "%ld%s", & thisfilesize, thisfilename );
    if ( thisfilesize > cutoff && !check_do_ignore( ignore_list_argument, thisfilename ) ) {
      printf("rm %s\n", thisfilename);
    }
  }
  return 0;
}

// possible file sizes:
//   1200
//   13.5K
//   77M
//   1.45G
long normalized_file_size( char *filesize ) {
  int length = strlen(filesize);
  if ( filesize[length-1] == 'K' ) {
    filesize[length-1] = '\0';
    return 1024 * atof(filesize);
  }
  if ( filesize[length-1] == 'M' ) {
    filesize[length-1] = '\0';
    return 1024*1024 * atof(filesize);
  }
  if ( filesize[length-1] == 'G' ) {
    filesize[length-1] = '\0';
    return 1024*1024*1024 * atof(filesize);
  }
  return atol(filesize);
}

// ignore_list is specified as ".o,.tar"
int check_do_ignore( char *ignore_list_argument, char *filename ) {
  char *ignore_suffixes[NUM_IGNORE];
  int i = 0;
  ignore_suffixes[i] = strtok( ignore_list_argument, "," );
  while ( (ignore_suffixes[++i] = strtok( NULL, "." )) != NULL ); 
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
