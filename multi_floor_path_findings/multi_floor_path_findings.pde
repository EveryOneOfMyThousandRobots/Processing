final int TILE_W = 96; //<>//
final int TILE_H = 32;


final int VIEWPORT_W= TILE_W * 6;
final int VIEWPORT_H = TILE_H * 10;

final int PLAY_X = TILE_W * 2;
final int PLAY_Y = 0;
int playXOffset = 0;
int playYOffset = 0;

final int TILES_ACROSS = 6;
final int TILES_DOWN = 10;

final int GAME_AREA_SIZE_W = TILES_ACROSS * TILE_W;
final int GAME_AREA_SIZE_H = TILES_DOWN  * TILE_H;

final int GUI_W = TILE_W * 2;
final int GUI_H = VIEWPORT_H;
final int GUI_X = 0;
final int GUI_Y = 0;

final int NODES_ACROSS = 12;
final int NODES_DOWN = 4;

PFont font;

UnitManager unitManager = new UnitManager();

long TIME_NOW;
long TIME_LAST;

Tile selectedTile;
enum STATE {
  WAITING,
}
Tile[][] tiles;


void settings() {
  size(VIEWPORT_W + (TILE_W * 2), VIEWPORT_H);
}




//float time_delta = 0;

void setup() {
  makeNodeMaps();
  font = createFont("Consolas", 10);
  textFont(font);
  gui = new ControlP5(this);
  guiSetup();

  tiles = new Tile[TILES_ACROSS][TILES_DOWN];
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      if (y < 4) {
        tiles[x][y] = new Tile(x, y, TT.SKY);
      } else if (y == 4) {
        if (x == TILES_ACROSS / 2) {
          tiles[x][y] = new Tile(x, y, TT.STAIRWELL);
        } else {
          tiles[x][y] = new Tile(x, y, TT.GRASS);
        }
      } else if (y == 5) {
        if (x == TILES_ACROSS / 2) {
          tiles[x][y] = new Tile(x, y, TT.STAIRWELL);
        } else {
          tiles[x][y] = new Tile(x, y, TT.ROOM);
        }
      } else if (y > 4) {
        if (x == TILES_ACROSS / 2) {
          tiles[x][y] = new Tile(x, y, TT.STAIRWELL);
        } else {
          tiles[x][y] = new Tile(x, y, TT.DIRT);
        }
      }
    }
  }
  setTileNeighbours();
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      println(tiles[x][y].toString(true));
      tiles[x][y].setNodeNeighbours();
    }
  }


  while (unitManager.units.size() < 5) {
    Node n = getRandomNode(null);

    if (n != null) {
      unitManager.units.add(new Unit(n));
    }
  }

  TIME_NOW = TIME_LAST = getTime();
}

long getTime() {
  return System.nanoTime() / (long)10e6;
}

void draw() {
  TIME_NOW = getTime();
  float time_delta = ((float)(TIME_NOW - TIME_LAST)) / (1000.0f / 60.0f);
  TIME_LAST = TIME_NOW;
  background(0);

  //draw tiles
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile tile = tiles[x][y];
      tile.update();
      tile.draw();
    }
  }

  unitManager.UpdateAndDraw(time_delta);


  if (selectedTile != null) {
    selectedTile.drawSelected();
  }


  //draw gui

  stroke(51);
  fill(0, 240);
  rect(GUI_X, GUI_Y, GUI_W, GUI_H);
  Tile t = getTileAtScreenCoord(mouseX, mouseY);
  fill(255);
  textAlign(LEFT, CENTER);
  if (t != null) {

    text(t.x + "," + t.y, 10, 10);
  }
  text(screenToWorldXI(mouseX) + "," + screenToWorldYI(mouseY), 10, 20);
  text("mouseOverGUI: " + mouseOverGUI(), 10, 30);
  text("mouseOverPlay: " + mouseOverPlay(), 10, 40);

  //if (selectedTile != null) {
  //  text("selected: " + selectedTile.toString(), 10, 50);
  //}
  text(nfc(time_delta, 4), 10, 50);

  //if (path != null) {
  //  if (path.path.size() > 0) {
  //    stroke(255);
  //    strokeWeight(2);
  //    noFill();
  //    beginShape();
  //    for (Node n : path.path) {
  //      vertex(n.pos.x - playXOffset, n.pos.y - playYOffset);
  //    }
  //    endShape();
  //    strokeWeight(1);
  //  }
  //}


}
