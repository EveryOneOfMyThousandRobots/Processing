ArrayList<Mover> balls = new ArrayList<Mover>();
PVector wind;
PVector grav;
void setup() {
  size(400, 400);
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(width / 2, height / 2, random(5,10), random(10,20));
    b.applyForce(PVector.random2D());
    balls.add(b);
  }
  wind = new PVector(2, 0);
  grav = new PVector(0, .1);
}


void draw() {
  background(255);
  for (Mover b : balls) {
    b.applyFriction(0.01);
    b.applyGravity(grav);
    b.update();
    b.draw();
  }
}

void mouseClicked() {
  PVector mouse = new PVector(mouseX, mouseY);
  for (Mover b : balls) {
    b.applyForce(PVector.sub(mouse,b.loc).normalize().mult(50));
  }
}