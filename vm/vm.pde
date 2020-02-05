PFont font;
VM vm;
void setup () {
  size(640,480);
  font = createFont("Nouveau IBM", 12);
  textFont(font);
  vm = new VM();
  
}

void draw() {
  background(0);
  vm.tick();
  vm.drawDebug();
}
