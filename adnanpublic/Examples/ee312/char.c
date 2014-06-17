#include <stdio.h>

int main() {
   char c;
   int d;
   c = 65;
   d = 66;
   int e = 'c';
   printf("c = %c (char)\n", c );
   printf("c = %d (integer)\n", c );
   printf("d = %c (char)\n", d );
   printf("d = %d (integer)\n", d );
   printf("e = %c (char)\n", e );

   c = 1079;
   printf("c = %c (char)\n", c );
   printf("c = %d (integer)\n", c );

   c = 'A' - 5;
   printf("c = %c (char)\n", c );
   printf("c = %d (integer)\n", c );

   d = 1079;
   printf("d = %c (char)\n", d );
   printf("d = %d (integer)\n", d );

   c = '?';
   printf("c = %c (char)\n", c );
   printf("c = %d (integer)\n", c );

   c = '\?';
   printf("c = %c (char)\n", c );
   printf("c = %d (integer)\n", c );

   return 0;
}
