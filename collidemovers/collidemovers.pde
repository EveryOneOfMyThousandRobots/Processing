import java.awt.Rectangle;
ArrayList<Shp> shapes = new ArrayList<Shp>();
int boxSize = 20;
int boxSize2 = boxSize * 2;
void setup() {
  size(400, 400);
  for (int i = 0; i < 10; i++) {
    Shp s;
    s = new Shp(random(boxSize2, width - boxSize2), random(boxSize2,height - boxSize2), boxSize, boxSize);
    PVector force = new PVector(random(-0.01, 0.01), random(-0.01, 0.01));
    s.force(force);
    shapes.add(s);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < shapes.size(); i++) {
    Shp s = shapes.get(i);
   
    s.update();
    for (int k = i + 1; k < shapes.size(); k++) {
      Shp os = shapes.get(k);
      s.collides(os);
    }     
    s.draw();
    

    
  }
}

class Shp {
  Rectangle box;
  float mass;
  PVector pos, size, vel, acc;
  Shp(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    box = new Rectangle();
    mass = w * h;
    updateRect();
  }

  void updateRect() {
    box.x = (int)pos.x;
    box.y = (int)pos.y;
    box.width = (int)size.x;
    box.height = (int)size.y;
  }

  void force(PVector force) {
    acc.add(force.copy().mult(mass));
  }

  void draw() {
    rect(pos.x, pos.y, size.x, size.y);
  }
  void reverse() {
    vel.x *= -1;
    vel.y *= -1;
   // vel.mult(0.99);
  }

  void update() {
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    updateRect();
    checkBounds();
  }

  void collides(Shp o) {
    if (this.box.intersects(o.box)) {
      print(" oh no!");
      o.reverse();
      this.reverse();
    }
  }

  void checkBounds() {
    if (pos.x <= 0 || pos.x + size.x >= width) {
      vel.x *= -1;
     // vel.x *= 0.99;
    }

    if (pos.y <= 0 || pos.y + size.y >= height) {
      vel.y *= -1;
    //  vel.y *= 0.99;
    }
  }
}