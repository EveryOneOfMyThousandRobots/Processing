class Worker {
  PVector pos;
  Worker() {
    pos = new PVector(width / 2, height / 2);
    
  }

  void draw() {
    stroke(255);
    fill(200);
    rect(pos.x, pos.y, 5,5);
  }
  void update() {
  }
}
