#include "Point.hh"

class Circle : public Point {
  public:
    Circle(int x, int y, int r);
    void print();
  private:
    int m_r;
};
