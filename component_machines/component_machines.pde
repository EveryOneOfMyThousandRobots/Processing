

Machine machine;
void setup() {
  size(600, 600);
  machine = new Machine(2, 5, 5, 2);
}
float[] fa = {0, 0};

void draw() {
  background(0);
  machine.setInput(fa);
  machine.update();
  float x = machine.output.comps.get(0).value;
  float y = machine.output.comps.get(1).value;
  
  text("(" + nfc(x,3) + "," + nfc(y, 3) + ")", 10, 10);
  
  
  
  fa[0] = x;
  fa[1] = y;
  machine.draw();
  
  ellipse((width /2) + x,(height/2)+ y, 10, 10);
}
