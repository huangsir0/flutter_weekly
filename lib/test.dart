import 'dart:math' as math;

void main() {
  print("哈哈");
  var random = new math.Random();

  List redNum = new List();

  while(redNum.length<6){
    int temp = random.nextInt(33)+1;
    if(!redNum.contains(temp)){
      redNum.add(temp);
    }
  }
  redNum.sort();
  
  print("red:"+redNum.toString());
  
  print("blue:"+(random.nextInt(16)+1).toString());
  
}
