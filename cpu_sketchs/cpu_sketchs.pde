PFont ibm;
Machine machine;
void setup() {
  size(500,500);
  machine = new Machine(8,24);
  machine.cpu.dataBus.write(29);
  //machine.cpu.dataBus.prints();
  ibm = createFont("Nouveau ibm", 14);
  textFont(ibm);
}


void draw() {
  background(0);
  machine.tick();
  machine.draw();
}
