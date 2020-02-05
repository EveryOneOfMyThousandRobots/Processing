RX rx;
TX tx;
BUS bus;
PFont fontIBM;

void setup() {
  size(500, 500);
  bus = new BUS();
  rx = new RX(10, 10, bus);
  tx = new TX("This is a new Message\n", width/2, 10, bus);
  fontIBM = createFont("Nouveau IBM", 14);

  textFont(fontIBM);
}


void draw() {
  background(0);
  tx.update();
  rx.update();
  tx.draw();
  rx.draw();
  bus.draw();
}

String toBin(char c) {
  String b = Integer.toBinaryString(c);

  b = "00000000" + b;

  b = b.substring(b.length()-8);

  return b;
}

boolean isHigh(float n) {
  return (n > 0.9);
}
