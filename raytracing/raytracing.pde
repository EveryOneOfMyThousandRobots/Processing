class Ray {
  float a, len;
  boolean collides = false;
  float cx, cy;
  Ray(float a, float len) {
    this.a = a;
    this.len = len;
  }

  void draw(float x, float y) {
    PVector p = PVector.fromAngle(a);

    p.mult(len);
    p.add(x, y);


    if (collides) {
      stroke(255, 0, 0);
      if (cx > -1 && cy > -1) {
        p.x = cx;
        p.y = cy;
      }
    } else {
      stroke(255);
    }
    line(x, y, p.x, p.y);
  }

  boolean trace(float x, float y) {
    boolean r = false;

    PVector line = PVector.fromAngle(a);
    PVector copy = line.copy();

    for (float i = 0; i < len; i += 1) {
      copy.add(line.x, line.y);
      float xx = copy.x + x;
      float yy = copy.y + y;
      cx = cy = -1;

      for (Obstacle o : blocks) {
        if (xx >= o.pos.x && xx <= o.pos.x + o.dim.x && yy >= o.pos.y && yy <= o.pos.y + o.dim.y) {
          cx =xx;
          cy = yy;
          r = true;
          break;
        }
      }
      if (r) break;
    }
    collides = r;
    return r;
  }
}

class M {

  PVector pos, dim;
  float angle;

  Ray eyeline;

  M(float x, float y) {
    pos = new PVector(x, y);
    eyeline = new Ray(0, 50);
  }

  void draw() {
    stroke(255);
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 20, 20);
    eyeline.draw(pos.x, pos.y);
  }

  void update() {
    PVector mv = new PVector(mouseX, mouseY);
    PVector me_to_mouse = PVector.sub(mv, pos);
    PVector me_to_edge = PVector.sub( new PVector(width, height / 2), pos);
    angle = angle(me_to_edge, me_to_mouse );
    eyeline.a = angle;
    eyeline.len = me_to_mouse.mag();
    eyeline.trace(pos.x, pos.y);
  }
}

float angle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}



class Obstacle {
  PVector pos, dim;

  Obstacle (float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dim = new PVector(w, h);
  }

  void draw() {
    stroke(0);
    fill(255);
    rect(pos.x, pos.y, dim.x, dim.y);
  }
}

ArrayList<Obstacle> blocks = new ArrayList<Obstacle>();
M m;
void setup() {
  size(400, 400);

  m = new M(width / 2, height /  2);
  blocks.add(new Obstacle(0, 0, width, 50));
  blocks.add(new Obstacle(0, height-50, width, 50));

  for (int i = 0; i < 15; i += 1) {
    float a = random(0, TWO_PI);
    
    float x = (width / 2) + (width / 4) * cos(a);
    float y = (width / 2) + (width / 4) * sin(a);
    float w = random(10, 20);
    float h = random(10, 20);
    blocks.add( new Obstacle(x, y, w, h));
  }
  background(0);
}

void draw() {
 // background(0);

  for (Obstacle o : blocks) {
    o.draw();
  }
  m.update();
  m.draw();
  fill(0);
  /*
  text(m.angle, 10, 10);
  text(m.eyeline.len, 10, 30);
  text(m.eyeline.cx + ","+ m.eyeline.cy, 10, 50);
  */
}