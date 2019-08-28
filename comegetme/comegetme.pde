ArrayList<Conveyor> cnvs = new ArrayList<Conveyor>();

void setup() {
  size(800, 800);
  boolean ls = false;
  for (int x = 0; x < width; x += CONVEYOR_WIDTH) {


    if (x == 0 || x >= width - CONVEYOR_WIDTH) {
      ls = x == 0;
      for (int y = 0; y < height; y += CONVEYOR_HEIGHT) {
        boolean top = y == 0;
        if (y < height - CONVEYOR_HEIGHT) {

          cnvs.add(new Conveyor(x, y, (ls ? DIR._DOWN : DIR._UP)));
        } else {
          cnvs.add(new Conveyor(x, y, DIR._RIGHT));
        }
      }
    }
  }
}

void draw() {
  background(0);

  for (Conveyor c : cnvs) {
    c.draw();
  }
}
