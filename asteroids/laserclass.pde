class Laser {

  PVector pos;
  PVector vel;
  boolean alive =true;

  Laser(Ship ship) {
    pos = ship.pos.copy();
    vel = PVector.fromAngle(ship.heading + random(-0.05, 0.05));
    vel.mult(10);
  }

  void update() {
    pos.add(vel);
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      alive = false;
    } else {

      for (int i = asteroids.size()-1; i >= 0; i -= 1) {
        Asteroid a = asteroids.get(i);
        float dist = PVector.dist(pos, a.pos);
        if (dist < a.r) {
          a.breakApart();
          alive= false;
        }
      }
    }
  }

  void draw() {
    noFill();
    stroke(0, 128, 60);
    ellipse(pos.x, pos.y, 2, 2);
  }
}