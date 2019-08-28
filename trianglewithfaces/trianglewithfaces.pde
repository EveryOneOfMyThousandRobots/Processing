import java.awt.geom.Area;
import java.awt.Polygon;
long lastFrame = 0;
long timeNow = 0;
int numChecks = 0;
int neighboursFound = 0;
int neighboursNeighboursfound = 0;

PImage bg;

void settings() {
  bg = loadImage("cogs.jpg");
  size(bg.width, bg.height);
}
void setup() {
  //size(500,500);
  bg.loadPixels();
  PVector a = new PVector(width / 2, height / 2);
  PVector b = randVector(a.x, a.y);
  PVector c = randVector(a.x, a.y);
  tris.add(new Tri(getPolygon(a, b, c)));
  
}

void draw() {
  timeNow = millis();
  background(0);
  drawTris();
  findNext();
  fill(255);
  text(int(timeNow - lastFrame), 10, 10);
  text(int(numChecks) + ", " + int(neighboursFound) + ", " + int(neighboursNeighboursfound), 10, 30);
  
  lastFrame = timeNow;
}

void drawTris() {
  for (Tri t : tris) {
    t.draw();
    t.update();
  }
}
