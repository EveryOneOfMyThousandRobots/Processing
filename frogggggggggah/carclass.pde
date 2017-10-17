class Car extends Rectangle {
  float speed;
  Car (float x, float y, float w, float h, float speed) {
    super(x, y, w, h);
    this.speed = speed;
  }

  void draw() {
    stroke(255);
    fill(255,0,0);
    rect(x, y, w, h);
  }
  
  void update() {
    x += speed;
    if (speed > 0 && x > width) {
      x = -w;
    } else if (speed < 0 && x + w < 0) {
      x = width + w;
    }
  }
}