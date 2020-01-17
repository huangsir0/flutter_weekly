abstract class Animal {

}

abstract class Run {
  void run() => print("会跑");
}

abstract class Fly {
  void fly() => print("会飞");
}

abstract class Swim {
  void swim() => print("会游泳");
}

class Bird extends Animal implements Fly {
  @override
  void fly() {
    // TODO: implement fly
    //super.run();//编译报错，它会认为抽象类 Fly中的fly()方法是抽象的（真实的并不是抽象的），
    print("会飞");
  }
}

class Dog extends Animal implements Run, Swim {
  @override
  void run() {
    // TODO: implement run
    print("会跑");
  }

  @override
  void swim() {
    // TODO: implement swim
    print("会游泳");
  }
}

class Person extends Animal implements Run, Swim, Fly {
  @override
  void fly() {
    // TODO: implement fly
    print("会飞");
  }

  @override
  void run() {
    // TODO: implement run
    print("会跑");
  }

  @override
  void swim() {
    // TODO: implement swim
    print("会游泳");
  }
}




