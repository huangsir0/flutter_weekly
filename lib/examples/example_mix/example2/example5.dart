
class Animal{

}

mixin Walk {
  void walk() {
    print("会走路了");
  }
}

mixin Dance on Animal, Walk {
  void dance() {
    print("居然会跳舞了");
  }
}

//class Person with Dance {} 错误的写法，编译不通过

//class Person with Walk, Dance {} 错误的写法，编译不通过

class Person extends Animal with Walk, Dance {}

void main() {
  Person person = new Person();
  person.walk();
  person.dance();
}
