int numFlakes = 20;
PVector GRAVITY = new PVector(0, 1);
Grid grid;





ArrayList<Flake> flakes = new ArrayList<Flake>();

void setup() {
  size(600, 600);
  grid = new Grid(20);
  makeFlakes();
}

void makeFlakes() {
  while (flakes.size() < numFlakes) {
    int r = floor(random(10, 30));
    float y = random(-(4 * r), -r);
    float x = random(width);
    int s = floor(random(6, 11));
    Flake f = new Flake(s, r, x, y);
    flakes.add(f);
  }
}

void draw() {
  background(0);
  for (int i = flakes.size()-1; i >= 0; i -= 1) {
    Flake flake = flakes.get(i);
    flake.applyForce(GRAVITY);
    flake.applyForce(grid.getForce(flake.pos.x, flake.pos.y));
    flake.update();
    flake.draw();

    if (flake.pos.y > height + flake.radius || flake.pos.x < -flake.radius || flake.pos.x > width + flake.radius) {
      flakes.remove(i);
    }
  }
  makeFlakes();
  grid.setVectors();
  //grid.draw();
}