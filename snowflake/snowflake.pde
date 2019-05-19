
ArrayList<Particle> flake = new ArrayList<Particle>();
Particle current;

void setup() {
  size(600, 600);
  current = new Particle(width/2, 0);
}

void draw() {

  background(0);
  translate(width/2, height/2);


  for (int i = 0; i < 100; i += 1) {
    if (current.finished() || current.intersects(flake)) {
      flake.add(current);
      current = new Particle(width / 2, 0);
    } else {
      current.update();
    }
  }
  for (int i = 0; i < 6; i += 1) {
    rotate(PI / 3);
    //current.draw();
    for (Particle p : flake) {
      p.draw();
    }
    pushMatrix();
    scale(1, -1);
    //current.draw();
    for (Particle p : flake) {
      p.draw();
    }
    popMatrix();
  }
}
