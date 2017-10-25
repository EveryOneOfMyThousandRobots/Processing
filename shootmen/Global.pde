ArrayList<Obstacle> blocks = new ArrayList<Obstacle>();
ArrayList<Man> men = new ArrayList<Man>();
final float BARRIER_W = 10, BARRIER_H = 10;
final PVector GRAVITY = new PVector(0, 0.1);
final PVector MOUSE = new PVector(0,0);

enum COLLISION {
  LEFT_RIGHT, UP_DOWN, NONE;
}