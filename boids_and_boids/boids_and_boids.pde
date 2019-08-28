final float MAX_DIST = 50;
int BOID_ID = 0;
QuadTree quadTree;
PVector mousePos, mouseDims;
ArrayList<Boid> boids = new ArrayList<Boid>();
ArrayList<Boid> results = new ArrayList<Boid>();
void setup() {
  size(600, 600);
  for (int i = 0; i < 100; i += 1) {
    boids.add(new Boid(random(width), random(height)));
  }
  mousePos = new PVector(mouseX, mouseY);
  mouseDims = new PVector(200, 200);
}



void draw() {
  background(0);
  quadTree = new QuadTree(0, 0, width, height);
  for (Boid b : boids) {
    quadTree.added(b);
  }
  for (Boid b : boids) {
    b.update();
    b.draw();
  }
  //quadTree.draw();
  //mousePos.set(mouseX,mouseY);

  //stroke(0, 255, 0, 64);
  //fill(0, 255, 0, 32);
  //ellipse(mousePos.x, mousePos.y, mouseDims.x, mouseDims.x);

  //results.clear();
  //quadTree.GetWithinRange(mousePos, mouseDims.x, results);
  //stroke(0, 255, 100, 128);
  //fill(0, 255, 100, 64);
  //for (Boid b : results) {
  //  ellipse(b.pos.x, b.pos.y, 20, 20);
  //}
}
