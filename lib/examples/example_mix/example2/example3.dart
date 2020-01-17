

//Object
class O {
  String getMessage() => "";
}

mixin A {
  String getMessage() => 'A';
}

mixin B {
  String getMessage() => "B";
}

class AB extends O with A, B {}

class BA extends O with B, A {}

void main() {
  String result1  = "";
  String result2  = "";

  AB ab = AB();
  result1= ab.getMessage();
  print("ab is ${ab is A}");
  print("ab is ${ab is B}");
  print("ab is ${ab is O}");

  BA ba = BA();
  result2 += ba.getMessage();
  print("ba is ${ab is B}");
  print("ba is ${ab is A}");
  print("ba is ${ab is O}");

  print(result1);
  print(result2);
}
