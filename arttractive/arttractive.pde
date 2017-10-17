//gravity =
// f = G * (m1 * m2 / d^2)
float G = 6.67408;//E-11;
ArrayList<PVector> attractors = new ArrayList<PVector>();

ArrayList<Particle> particles = new ArrayList<Particle>();
void setup () {
  size(400, 400, P2D);
  colorMode(HSB);
  smooth();
  for (int i = 0; i < 5; i += 1) {
    attractors.add(new PVector(random(width), random(height)));
  }
  for (int i = 0; i < 20; i += 1) {
    Particle p = new Particle(width /2, height / 2);
    p.vel = PVector.random2D();

    particles.add(p);
  }
  background(51);
}

void draw() {
  noStroke();
  fill(51, 10);
  rect(0, 0, width, height);
  stroke(128);
  strokeWeight(1);
  for (PVector v : attractors) {

    ellipse(v.x, v.y, 8, 8);
  }

  for (Particle p : particles) {
    for (PVector v : attractors) {

      p.attracted(v);
    }

    p.update();
    p.draw();
  }
}