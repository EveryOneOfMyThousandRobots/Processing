
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 600;
final int ARENA_XPOS = 100;
final int ARENA_WIDTH = WINDOW_WIDTH - (ARENA_XPOS*2);
final int ARENA_YPOS = 100;
final int ARENA_HEIGHT = WINDOW_HEIGHT - (ARENA_YPOS*2);
final int ARENA_OFFSCREEN_SIZE = 50;
final PVector ARENA_POS = new PVector(ARENA_XPOS, ARENA_YPOS);
Player player;

ArrayList<MovingEntity> entities = new ArrayList<MovingEntity>();
ArrayList<Rock> rocks = new ArrayList<Rock>();

void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
  player = new Player(width / 2, height / 2);
  entities.add(player.entity);
}

void checkCollisions() {
  
}

void draw() {
  background(0);


  stroke(255);
  fill(0);
  rect(0, 0, WINDOW_WIDTH, ARENA_YPOS);
  noFill();
  rect(ARENA_XPOS, ARENA_YPOS, ARENA_WIDTH, ARENA_HEIGHT);

  for (int i = rocks.size()-1; i >= 0; i -= 1) {
    Rock r = rocks.get(i);
    r.update();
    r.draw();
  }


  player.update();
  player.draw();


  for (int i = shots.size()-1; i >= 0; i -= 1) {
    Shot s = shots.get(i);

    s.update();

    if (s.entity.wentOffScreen) {
      shots.remove(i);
    }
    s.draw();
  }

  if (rocks.size() < 5 && random(1) < 0.1) {
    rocks.add(new Rock());
  }
  stroke(255);
  fill(0);
  rect(0, 0, WINDOW_WIDTH, ARENA_YPOS);
  fill(255);
  text("player pos: " + player.entity.mover.pos, 10, 10);
  text("rocks: " + rocks.size(), 10, 30);
  text("shots: " + shots.size(), 10, 50);
}
