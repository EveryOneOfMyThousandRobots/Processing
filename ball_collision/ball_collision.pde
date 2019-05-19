final int WINDOW_WIDTH = 160 * 8;
final int WINDOW_HEIGHT = 120 * 8;
ArrayList<Ball> balls = new ArrayList<Ball>();
void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}
void setup() {
  while (balls.size() < 5) {
    balls.add(new Ball());
  }
}

boolean isOverlapping(Ball a, Ball b) {
  float dist = PVector.dist(a.pos, b.pos);
  if (dist < a.radius + b.radius) {
    return true;
  } 
  return false;
}

void checkCollisions() {
  for (int i = 0; i < balls.size(); i += 1) {
    Ball a = balls.get(i);
    for (int j = 0; j < balls.size(); j += 1) {
      Ball b = balls.get(j);
      if (a.id != b.id) {
        if (isOverlapping(a,b)) {
          
        }
      }
    }
  }
}


void draw() {
  background(0);
  for (Ball b : balls) {
    b.update();
    b.draw();
  }
}
