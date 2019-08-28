Map map;
Cell[][] cells;
ArrayList<Colony> colonies = new ArrayList<Colony>();
int mapCounter = 0;
void setup() {
  size(400, 400);

  map = new Map(width / 2, height / 2);
  map.generate();
  cells = new Cell[width / 2][height / 2];

  makeColony(color(255, 0, 0));
  makeColony(color(255, 255, 0));
  makeColony(color(255, 0, 255));
  makeColony(color(128, 0, 0));
  makeColony(color(0, 128, 0));
  makeColony(color(0, 0, 128));
  makeColony(color(0, 0, 0));

  //frameRate(4);
  frameRate(100);
}

void makeColony(color c) {
  int[] coords = map.getLand();
  colonies.add(new Colony(coords[0], coords[1], 50, c));
}

void draw() {
  background(0);
  image(map.map, 0, 0, width, height);
  image(map.food, 0, 0, width, height);

  float y = 10;

  for (Colony col : colonies) {
    for (int i = 0; i < 2; i += 1) {
      col.update();
    }
    col.draw();


    fill(0);
  }
  mapCounter += 1;

  if (mapCounter > REFRESH_MAP_FRAMES) {
    mapCounter = 0;
    map.generate();
  }

  noStroke();
  fill(255, 180);
  rect(0, 0, 100, 100);  
  fill(0);
  for (int i = colonies.size()-1; i >= 0; i -= 1) {
    Colony col = colonies.get(i);
    fill(col.col);
    text(col.id + " " + col.cells.size() + " " + nfc(col.avgStrength, 2), 10, y);
    y += 10;

    if (col.cells.size() == 0) {
      color saveCol = col.col;
      colonies.remove(i);
      makeColony(saveCol);
    }
  }

  int mx = mouseX / 2;
  int my = mouseY / 2;

  FloorType f = map.get(mx, my);
  float food = map.getFood(mx, my);
  noStroke();
  fill(255,180);
  rect(mouseX, mouseY, 100, 30);
  fill(0);
  text(f + " " + food, mouseX+10, mouseY+10);
  
}


void mouseClicked() {
}
