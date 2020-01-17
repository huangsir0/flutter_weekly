abstract class Animal {}

mixin Run {
  void run() => print("会跑");
}

mixin Fly {
  void fly() => print("会飞");
}

mixin Swim {
  void swim() => print("会游泳");
}

class Bird extends Animal with Fly {
  @override
  void fly() {
    super.fly(); //合情合理合法
  }
}

class Dog extends Animal with Run, Swim {
  @override
  void run() {
    super.run();
  }

  @override
  void swim() {
    // TODO: implement swim
    super.swim();
  }
}

class Person extends Animal with Run, Swim, Fly {
  @override
  void fly() {
    super.fly(); //合情合理合法
  }

  @override
  void run() {
    super.run();
  }

  @override
  void swim() {
    // TODO: implement swim
    super.swim();
  }
}

void main() {
  Person person = new Person();
  person.fly();
  person.run();
  person.swim();
}
