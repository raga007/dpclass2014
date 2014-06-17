class Point {
  public:
    Point();
    Point(int, int);
    virtual void print()=0;
    int x();
    int y();
    void x(int);
    void y(int);
    void moveTo(Point);
  private:
    int m_x, m_y;
};
