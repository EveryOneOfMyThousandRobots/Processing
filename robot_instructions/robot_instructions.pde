

final int BIN_SIZE = 20;
PFont sysfont;
RB robot;
void setup() {
  size(400,400);
  robot = new RB();
  sysfont = createFont("Consolas", 10);
  int x = BIN_SIZE / 2;
  for (int y = BIN_SIZE; y < height - BIN_SIZE; y += BIN_SIZE) {
    bins.add(new Bin(x, y));
    
  }
  x = width - BIN_SIZE / 2;
  for (int y = BIN_SIZE; y < height - BIN_SIZE; y += BIN_SIZE) {
    bins.add(new Bin(x, y));
    
  }
}

void draw() {
  background(255);
  
  for (Bin b: bins) {
    b.draw();
  }
  robot.update();
  robot.draw();
  
  
}
