ArrayList<Mob> mobs = new ArrayList<Mob>();
final float MOB_RADIUS = 10;

void setup() {
  size(400,400);
  mobs.add(new Mob(width / 2, height / 2, null));
}


void draw() {
  background(0);
  for (Mob m : mobs) {
    m.update();
    m.draw();
  }
}
