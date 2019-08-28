enum DIR {

  _UP("UP"), _DOWN("DOWN"), _LEFT("LEFT"), _RIGHT("RIGHT");
  private final String name;

  private DIR(String name) {
    this.name = name;
  }
  
  String getName() {
    return name;
  }
}


final int CONVEYOR_WIDTH = 25;
final int CONVEYOR_HEIGHT = 25;

class Conveyor {
  PVector pos;
  DIR dir;


  Conveyor(float x, float y, DIR dir) {
    pos = new PVector(x, y);
    //dims = new PVector(w, h);

    this.dir = dir;
  }

  void draw() {

    stroke(0);
    fill(100);
    rect(pos.x, pos.y, CONVEYOR_WIDTH, CONVEYOR_HEIGHT);
    fill(255);
    text(dir.getName(), pos.x + 5, pos.y + 10);
  }
}
