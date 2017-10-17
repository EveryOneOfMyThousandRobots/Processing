final int POP_SIZE = 100;
final float MUTATION_RATE = 0.01;
final int RESTART_AFTER = 600;
PVector target;
PVector start;
ArrayList<Obstacle> blocks = new ArrayList<Obstacle>();


Pop pop;
void setup() {
  size(800, 400);
  target = new PVector(width - 10, height / 2);
  
  start = new PVector(10, height / 2);
  
  pop = new Pop();
  
  blocks.add(new Obstacle(width / 4, height / 8, 10, 6 * (height /8)));
  blocks.add(new Obstacle(width / 2, -height/4, 10, height / 2));
  blocks.add(new Obstacle(width / 2, height - (height / 4), 10, height / 2));
  blocks.add(new Obstacle(width - (width / 4), height / 8, 10, 6 * (height /8)));
}

void draw() {
  background(0);
  pop.update();
  pop.draw();
  
  for (Obstacle o : blocks) {
    o.draw();
  }
  
  stroke(255);
  fill(255,0,0);
  ellipse(target.x, target.y, 10, 10);
}