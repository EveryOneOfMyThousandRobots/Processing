

final String alphabet = "0123456789ABCDEFGHJKLMPQRSTVWXYZ";
ArrayList<Bin> bins = new ArrayList<Bin>();


String getChar(int i) {
  return alphabet.substring(i,i+1);
}

class Bin {
  byte c1, c2, c3, c4, c5, c6, c7;
  
  String getCode() {
    return ""+getChar(c1)+getChar(c2)+getChar(c3)+getChar(c4)+"-"+getChar(c5)+getChar(c6)+getChar(c7);
  }
  
  String getVal() {
    return c1 + ":" + c2 + ":" + c3 + ":" + c4 + ":" + c5 + ":" + c6 +":" + c7;
  }
  
  
  Bin() {
    c1 = rnd();
    c2 = rnd();
    c3 = rnd();
    c4 = rnd();
    c5 = rnd();
    c6 = rnd();
    c7 = rnd();
  }
}

byte rnd() {
  return (byte) (floor(random(0,32)) % 32);
}

void setup() {
  size(400,400);
  for (int i = 0; i < 10; i += 1) {
    Bin b = new Bin();
    bins.add(b);
  }
  
  for (int i = 0; i < bins.size(); i += 1) {
    Bin b = bins.get(i);
    println(i + " " + b.getCode() + " :: " + b.getVal() + " ");
  }
  
  
}

void draw() {
}