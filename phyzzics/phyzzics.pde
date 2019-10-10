
ArrayList<Phys> objs = new ArrayList<Phys>(); 

void setup() {
  
  size(400,400);
  for (int i = 0; i < 10; i += 1) {
    Phys p = new Phys(random(width), random(height));
    p.randomiseVel();
    objs.add(p);
  }
}

PVector GRAV = new PVector(0,0.1);
void draw() {
  background(0);
  for (Phys p : objs) {
    p.applyForce(GRAV);
    p.update();
    p.draw();
  }
}
