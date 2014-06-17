#include <iostream>
#include "Animal.hh"
#include "Cat.hh"
#include "Dog.hh"

using namespace std;

int main(void) {
  Cat c;
  Dog d;
  c.print();
  d.print();

  Animal aa[2];
  aa[0] = c;
  aa[1] = d;
  aa[0].print();
  aa[1].print();

  Animal animal = c;
  // ((Cat) animal).print();

  Animal *a[2];
  if ( 123 % 2 == 0 ) {
    a[0] = new Cat();
  } else {
    a[0] = new Dog();
  }
  a[1] = new Dog();
  a[0]->print();
  a[1]->print();
  
  Animal e = *(Animal *) a[0];
  e.print();

  Animal f = *a[0];
  f.print();

  return 0;
}
