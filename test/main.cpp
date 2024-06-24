#include <iostream>

struct mystruct {
    int a,b;

    mystruct ()
    {
        this-> a = 10;
        this-> b = 11;
    }
    void Init()
    {
    }
};

int main() {
  std::cout << "hello world" << std::endl;
  int a = 10;
  std::cout << a << std::endl;
  for (int i = 0; i < 10; i++) {
    std::cout << i << std::endl;
  }
  return 1;
}
