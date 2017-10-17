class Frog extends Rectangle {
  final float startX, startY;
  Frog(float x, float y, float w) {
    super(x, y, w, w);
    this.startX = x;
    this.startY = y;
  }

  void draw() {
    stroke(255);
    fill(0, 128, 0);
    rect(x, y, w, h);
  }

  void update() {
    for (Car car : cars) {
      if (car.intersects(this)) {
        this.x = startX;
        this.y = startY;
        break;
      }
    }
  }

  void move(float xDir, float yDir) {
    float newX = x + (xDir * tileSize);
    float newY = y + (yDir * tileSize);
    if (newX >= 0 && newX <= width - w && newY >= 0 && newY <= height-h) {
      setXY(newX,newY );
    }
  }
}