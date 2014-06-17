#include <iostream>
#include "Point.hh"

using namespace std;

int main(void) {
  Point p;
  Point q(10,15);

  p.print();
  q.print();

  q.x(-10);
  q.print();

  // q.Point::print();

  std::cout << q.x() << std::endl;

  return 0;
}
