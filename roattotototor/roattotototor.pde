ArrayList<Rotator> rotators = new ArrayList<Rotator>();

void setup() {
  size(300, 300);
  Rotator parent = null;
  float cx, cy,r, ai, a;
  cx = width / 2;
  cy = height / 2;
  r = width / 4;
  a = 0;
  ai = TWO_PI / 180;
  
  for (int i = 0; i < 3; i++) {
    
    Rotator rot = new Rotator(cx, cy, r, a, ai, parent);
    rotators.add(rot);
    parent = rot;
    cx = rot.x;
    cy = rot.y;
    r *= 0.5;
    ai *= 0.5;
    
  }
  background(0);

}

void draw() {
  noStroke();
  fill(0,12);
  rect(0,0,width,height);
  stroke(255);
  fill(255);
  for (Rotator r : rotators) {
    r.update();
    r.draw();
  }
}