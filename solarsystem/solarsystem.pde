PGraphics trails;

void setup() {
  size(600, 600);
  bodies.add(new Body(width / 2, height / 2, 100000, 10, true));
  PVector up = new PVector(0, -0.2);
  for (int i = 0; i < 10; i += 1) {

    float x = (width / 2) + ((i + 1) * (width / 20));
    Body b = new Body(x, height / 2, random(10000), random(5), false);
    b.applyForce(PVector.mult(up, b.mass));
    bodies.add(b);
  }
  trails = createGraphics(width,height);
  
  background(0);
}

void draw() {
  background(0);
  //background(0);
  for (Body body : bodies) {
    body.update();
    body.draw();
  }
  image(trails,0,0);
}