final PVector gravity = new PVector(0,0.1);
ArrayList<Firework> fireworks = new ArrayList<Firework>();
float fromX, toX;
Particle p;
void setup() {
  size(400,300);
  fromX = (width / 2) - (width / 8);
  toX = (width / 2) + (width / 8);
  for (int i = 0; i < 1; i += 1) {
    fireworks.add(new Firework());
  }
  background(51);
}

void draw() {
  noStroke();
  fill(51,100);
  rect(0,0,width, height);
  if (random(1) < 0.1) {
    fireworks.add(new Firework());
  }
  for (int i = fireworks.size()-1; i >= 0; i -= 1) {
    Firework f = fireworks.get(i);
    f.update();
    f.draw();
    
    if (f.exploded && f.particles.size() == 0) {
      fireworks.remove(i);
    }
  }
}