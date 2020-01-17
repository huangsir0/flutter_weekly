class Animal {}

mixin Walk on Animal {
  void walk() {
    print("会走路了");
  }
}

//class ZhiWu with Walk {}

class Person extends Animal with Walk {}
