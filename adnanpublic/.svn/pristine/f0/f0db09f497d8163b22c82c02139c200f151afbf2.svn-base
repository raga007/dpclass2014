#include <iostream>
#include "Point.hh"

using namespace std;


Point::Point() {
  cout << "No argument class constructor called!" << endl;
  m_x = m_y = 0;
}

Point::Point(int a, int b) {
  m_x = a;
  m_y = b;
}

//void Point::print() {
//  std::cout << "(" << m_x << ", " << m_y << ")";
//}

int Point::x() { return m_x; }
int Point::y() { return m_y; }

void Point::x(int xinit) { m_x = xinit; }
void Point::y(int yinit) { m_y = yinit; }

void Point::moveTo(Point p) { 
  m_x = p.m_x; 
  m_y = p.m_y; 
  print();
}
