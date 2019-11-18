int nodeCount = 0;
class River {
  
  int maxSplits = 4;
  int splits = 0;

  Node start;
  int x, y;
  River(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    if (start == null) {
      start = new Node(x, y, -HALF_PI, 8, this);
    } else {
      start.update();
    }
  }

  void draw() {
    start.draw();
  }
}
