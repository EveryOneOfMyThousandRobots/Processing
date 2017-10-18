ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Mover> movers = new ArrayList<Mover>();
void setup() {

  size(600, 600);

  for (int i = 0; i < 50; i += 1) {
    obstacles.add(new Obstacle());
  }

  for (int i = 0; i < 1; i += 1) {
    movers.add(new Mover());
  }
}

void draw() {
  background(255);
  for (Obstacle o : obstacles) {
    o.draw();
  }

  for (Mover m : movers) {
    m.update();
    m.draw();
  }
}

void mouseClicked() {
  for (Mover m : movers) {
    m.applyForce(PVector.random2D());
    
  }
}