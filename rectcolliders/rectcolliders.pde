import java.awt.Rectangle;
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<Creech> creatures = new ArrayList<Creech>();
final float WALL_WIDTH = 10;
final PVector GRAV = new PVector(0, 0.1);

void setup() {
  size(400,400);
  
  walls.add(new Wall(0, height - WALL_WIDTH, width, WALL_WIDTH));
  walls.add(new Wall(0,0,WALL_WIDTH, height));
  walls.add(new Wall(0,0, width, WALL_WIDTH));
  walls.add(new Wall(width - WALL_WIDTH, 0, WALL_WIDTH, height));
  creatures.add( new Creech(width / 2, height / 2, 10, 30));
}

void draw() {
  background(0);
  
  for(Wall wall : walls) {
    wall.draw();
  }
  
  for (Creech c : creatures) {
    c.applyForce(GRAV);
    c.applyForce(PVector.random2D());
    c.draw();
    c.update();
  }
}
