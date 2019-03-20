final int FACTORY_SIZE = 100;
final int STARTING_LOW_RESOURCES = 20;
final int STARTING_HIGH_RESOURCES = 10;
//final int STARTING_RESOURCES = 20;
boolean debug = false;
PFont fnt;
Graph graph;
long timeLast = 0;
long delta = 0;
long lastUpdate = 0;
PGraphics sideBar;
void setup() {
  size(800, 800);
  sideBar = createGraphics(width / 2, height);

  fnt = createFont("Consolas", 10);
  textFont(fnt);
  sideBar.beginDraw();
  sideBar.textFont(fnt);
  sideBar.endDraw();

  makeResources();
  makeRecipes();

  //for (Recipe r : recipes) {
  //  println(r);
  //}

  for (int x = 0; x < width/2; x += FACTORY_SIZE) {
    for (int y = 0; y < height; y += FACTORY_SIZE) {
      Factory f = new Factory(x, y);
      if (x == 0 && y == 0 ) {
        f.setImporter();
      }
    }
  }
  market.update();
  graph = new Graph();
}

void draw() {
  long timeNow = millis();
  delta = timeNow - timeLast;
  timeLast = timeNow;
  lastUpdate += delta;
  background(0);
  for (int i = factories.size()-1; i >= 0; i -= 1) {
    Factory f = factories.get(i);
    if (f.gold <= 0 ) {
      factories.remove(f);
      Factory ff = new Factory(f.pos.x, f.pos.y);
    } else {
      //something //<>//
      f.update();
    }
  }

  for (Factory f : factories) {
    f.draw();
  }
  fill(0);
  noStroke();
  rect((width / 2) + 1, 0, width / 2, height);
  market.update();

  if (lastUpdate > 1000) {
    lastUpdate = 0;
    sideBar.beginDraw();
    sideBar.background(0);
    lastUpdate = 0;
    market.draw();
    graph.update();
    graph.draw();
    sideBar.endDraw();
  }
  image(sideBar, width / 2, 0);
}
import java.awt.event.KeyEvent;
void keyReleased() {
  println(keyCode);
  if (keyCode == KeyEvent.VK_F5) {
    debug = !debug;
  }
}
