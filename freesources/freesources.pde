final int MAX_TRADERS = 20;
final int STARTING_RESOURCES = 10;
void setup() {
  size(800,800);
  
  for (int i = 0; i < STARTING_RESOURCES; i += 1) {
    new Resource();
  }
}

void draw() {
  background(0);
  for (int i = traders.size()-1; i >= 0; i -= 1) {
    Trader t = traders.get(i);
    t.update();
    t.draw();
    if (t.gold <= 0) {
      traders.remove(i);
    }
  }
  
  if (traders.size() < MAX_TRADERS && random(1) < 0.01) {
    new Trader(random(width), random(height), random(100,300));
  }
  int x = 10;
  int y = 10;
  for (Offer o : offers) {
    text(o.toString(), x,y);
    y += 10;
  }
  for (Resource r : resources) {
    text(r.name, 10, y);
    y += 10;
  }
}
