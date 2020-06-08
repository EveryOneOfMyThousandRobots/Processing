



Grid grid;
void setup() {
  size(600, 600);
  grid = new Grid(100, 100);
}


void draw() {
  background(0);
  grid.draw();
  grid.scentStep();
}

void mouseReleased() {
  grid.setScentAtScreenPos(mouseX,mouseY);
}
