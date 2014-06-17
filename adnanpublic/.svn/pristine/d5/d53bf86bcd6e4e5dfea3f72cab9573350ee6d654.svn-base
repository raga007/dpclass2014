#include <iostream>
#include "Circle.hh"

using namespace std;

Circle::Circle(int x, int y, int r) : Point::Point(x, y)
{
  m_r = r;
};

void Circle::print() { 
  cout << "Circle: " << m_r;
  cout << "center at " << x() << " " << y() ;
}

int main(void) {
  Circle c(1,2,4);
  c.moveTo(Point(4,4));
  c.print();
  return 0;
}
