
final float TILE_SIZE = 25;

enum Fade {
  NONE, LR, TB,TLBR, TRBL;
}

color RED = color(255,0,0);
color YELLOW = color(255,255,0);
color ORANGE = lerpColor(RED,YELLOW,0.5);

ArrayList<Area> areas = new ArrayList<Area>();
void setup() {
  size(1500, 500);
  noLoop();
  frameRate(2);

  Area a = new Area(0, 0, 500, 500, Fade.TRBL);
  a.colourA = RED;
  a.colourB = YELLOW;
  a.chanceLeft = 1;
  a.chanceRight = 0;  
  areas.add(a);

  a = new Area(500,0,500,500,Fade.TLBR);
  a.colourA = RED;
  a.colourB = YELLOW;

  areas.add(a);

  a = new Area(1000,0,500,500, Fade.TRBL);
  a.colourA = RED;
  a.colourB = YELLOW;
  a.chanceLeft = 0;
  a.chanceRight = 1;
  areas.add(a);
  
  for (Area aa : areas) {
    aa.render();
  }
}

void draw() {
  background(0);
  for (Area a : areas) {
    a.draw();
  }
}
