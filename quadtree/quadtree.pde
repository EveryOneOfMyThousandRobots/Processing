QuadTree quadtree;
ArrayList<Particle> particles = new ArrayList<Particle>();
Rectangle win;
boolean drawTree = false;
void setup() {
  size(400, 400);
  win = new Rectangle(0,0,width, height);
  quadtree = new QuadTree(win, 4);
  float xx = 0;
  float yy = 0;
  float zz = 0;
  for (int i = 0; i < 1000; i += 1) {
    float x = noise(xx + 10, yy + 10, zz + 10)*width;
    float y = noise(xx, yy, zz)*height;
    Particle p = new Particle(x, y);
    particles.add(p);
    quadtree.insert(p);
   // xx += 0.1;
    //yy += 0.1;
    zz += 0.1;
  }
  s = new Rectangle(random(width / 2), random(height / 2), random(width / 8, width / 2), random(height / 8, height / 2));
  //noLoop();
}

ArrayList<Particle> found = new ArrayList<Particle>();
Rectangle s = new Rectangle(random(width / 2), random(height / 2), random(10, 100), random(10, 100));
void draw() {
  s.x = mouseX - (s.w / 2);
  s.y = mouseY - (s.h / 2);
  background(255);
  quadtree.draw();

  stroke(0, 255, 0);
  strokeWeight(1);
  noFill();
  rect(s.x, s.y, s.w, s.h);
  found.clear();
  quadtree.query(s, found);
  //println(found.size());
  fill(0);
  text(found.size(), 10, 10);
  strokeWeight(4);
  for (Particle p : found) {
    point(p.pos.x, p.pos.y);
  }
  quadtree.reset();
  for (Particle p : particles) {
    p.update();
    quadtree.insert(p);
  }
}

//void mousePressed() {
//  quadtree.insert(new PVector(mouseX, mouseY));
//}
