#include <iostream>

using namespace std;

class FooBar {
    public:
      FooBar(unsigned int size=0, int initValue=0);
      FooBar(const FooBar&);
      ~FooBar();
      void print();
      void increment();
    private:
      unsigned int m_size;
      int *m_array;
  };

FooBar::FooBar(unsigned int size, int initValue) : m_size(size) {
  m_array = new int[m_size](initValue);
}

FooBar::FooBar(const FooBar& f) {
  cout << "Copy constructr ... " << endl;
  m_size = f.m_size;
  m_array = new int[m_size];
  for ( unsigned int i = 0 ; i < m_size; i++ ) 
    m_array[i] = f.m_array[i];
}

FooBar::~FooBar() {
  delete [] m_array;
  cout << "I have destroyed you" << endl;
}

void FooBar::increment() {
  for ( unsigned int i = 0 ; i < m_size; i++ ) 
    m_array[i]++;
}

void FooBar::print() {
  for ( unsigned int i = 0 ; i < m_size; i++ ) 
    cout << m_array[i] <<  " " ;
  cout << endl;
}

unsigned int rand() {
  static unsigned int r = 0;
  return (r = r*13 + 17);
}

int main() {
   const int kRandMax(8);
   for ( int i = 0 ; i < 100; i++ ) {
     FooBar f( rand()%kRandMax, rand() );
     f.print();
     FooBar g(f);
     f.increment();
     f.print();
     g.print();
   }
   FooBar *g = new FooBar( rand()%kRandMax, rand() );
   return 0;
}
