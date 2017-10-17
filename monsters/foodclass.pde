class Food {
  PVector pos;
  float nutrition;
  int coolDown = 0;
  Food() {
    pos = new PVector(0, 0);
    setPos(false);
  }

  void setPos(boolean withCoolDown) {
    float x = 0;
    float y = 0;
    while (x <= worldPos.x || x >= worldPos.x + worldDims.x) {
      x = boxmuller(worldPos.x - (worldDims.x / 2), worldPos.x + (worldDims.x * 1.5));
    }
    while (y <= worldPos.y || y >= worldPos.y + worldDims.y) {
      y = boxmuller(worldPos.y - (worldDims.y / 2), worldPos.y + (worldDims.y * 1.5));
    }

    pos.x = x;
    pos.y = y;
    nutrition = random(5, 20);
    if (withCoolDown) {
      coolDown = floor(random(100, 1000));
    }
  }

  void draw() {
    if (coolDown <= 0 ) {
      int idx = floor(pos.x) + floor(pos.y) * width;
      pixels[idx] = color(255, 0, 0);
    } else {
      coolDown -= 1;
    }
    //  stroke(255, 0, 0);
    //  fill(255, 0, 0);
    //  ellipse(pos.x, pos.y, 2, 2);
  }
}