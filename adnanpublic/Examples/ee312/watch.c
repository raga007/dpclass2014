int main(void) {

  int z;
  int x;
  int* p = &z;

  *p = 12;

  int *q = p;
  x = 15;
  z = 13;

  x = 44;
  *q = 123;

  *(&x - 1) = -112;

  return 0;
}

