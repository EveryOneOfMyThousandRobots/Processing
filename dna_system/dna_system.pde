class DNA {
  String address, text;

  DNA() {

    address = "";
    for (int i = 0; i < 100; i += 1) {
      address += str(floor(random(0, 4)));
    }

    text = "";
    for (int x = 0; x < 4; x += 1) {
      for (int y = 0; y < 4; y += 1) {
        for (int i = 0; i < 4; i += 1) {
          text += getRandomHex();
        }
      }
    }
  }
  
  String get(float x, float y) {
    return get(floor(x), floor(y));
  }
  
  String get(int x, int y) {
    int index = x + y * 4;
    println(index);
    return text.substring(index, index+4);
  }
  
  
}

String getRandomHex() {
  int i = floor(random(16));
  return hex(i, 1);
}

void setup() {
  size(500, 500);
  noLoop();
  DNA dna = new DNA();
  println(dna.address);
  println(dna.text);
  println(unhex(dna.get(1,1)));
}

void draw() {
}
