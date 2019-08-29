final int ROAD_WIDTH = 3;
final int BUILDING_MIN = 5;
final int BUILDING_MAX = 20;

final int BLOCK_WIDTH = 50;
final int BLOCK_HEIGHT = 50;
boolean biomesChecked = false;
enum TYPES {
  NONE, ROAD, WALL, INTERIOR;
}

boolean skipBiomes = false;

PFont sysFont;


TYPES[][] displayMap;
TYPES[][] typeMap;
int[][] biomeMap;

final int MAP_WIDTH = 400;
final int MAP_HEIGHT = MAP_WIDTH;
int RES = 0;
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = WINDOW_WIDTH;

PGraphics mapGraphics;
color[] colours = {
  #10C135, 
  #25963E, 
  #D19C4C, 
  #9D5F38, 
  #5d3a1a, 
  #4b3621, 
  #513b26, 
  #452f1a, 
  #654321
};

Biome base; 
void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  noSmooth();
  RES = WINDOW_WIDTH / MAP_WIDTH;
}
void setup() {
  sysFont = createFont("Consolas", 10);
  textFont(sysFont);
  mapGraphics = createGraphics(MAP_WIDTH, MAP_HEIGHT);

  reset();
}

void reset() {
  biomesChecked = false;
  buildings.clear();
  typeMap = new TYPES[MAP_WIDTH][MAP_HEIGHT]; 
  displayMap = new TYPES[MAP_WIDTH][MAP_HEIGHT];
  biomeMap = new int[MAP_WIDTH][MAP_HEIGHT];
  biomes = new ArrayList<Biome>();
  makeRoads();
  makeBuildings_EAST_WEST(-1);
  makeBuildings_NORTH_SOUTH(-1);
  makeBuildings_EAST_WEST(1);
  makeBuildings_NORTH_SOUTH(1);
  fixBuildings();
  erodeBuildings();
  addBiomes();
  for (int x = 0; x < MAP_WIDTH; x += 1) {
    for (int y = 0; y < MAP_HEIGHT; y += 1) {
      TYPES t = displayMap[x][y];
      if (t != null) {
        if (t != TYPES.INTERIOR) {
          biomeMap[x][y] = -1;
        }
      }
    }
  }
}

void addBiomes() {
  while (biomes.size() < 10) {
    biomes.add(new Biome(getColour()));
  }

  for (int x = 0; x < width; x += BLOCK_WIDTH) {
    for (int y = 0; y < height; y += BLOCK_WIDTH) {
      biomes.add(new Biome(getColour(), x, y, BLOCK_WIDTH, BLOCK_WIDTH));
    }
  }

  base = biomes.get(floor(random(biomes.size())));
}

void draw() {

  mapGraphics.beginDraw();
  mapGraphics.background(255);

  mapGraphics.loadPixels();
  for (int x = 0; x < MAP_WIDTH; x += 1) {
    for (int y = 0; y < MAP_HEIGHT; y += 1) {
      if (displayMap[x][y] != null) {
        switch( displayMap[x][y]) {
        case NONE:
          break;
        case ROAD:
          mapGraphics.pixels[y * MAP_WIDTH + x] = color(128);
          break;
        case WALL:
          mapGraphics.pixels[y * MAP_WIDTH + x] = color(255, 0, 0);
          break;
        case INTERIOR:
          mapGraphics.pixels[y * MAP_WIDTH + x] = color(255, 200, 0);
          break;
        }
      }

      int m = biomeMap[x][y];
      if (m > 0) {
        mapGraphics.pixels[y * MAP_WIDTH + x] = lookup.get(m).c;
      }
    }
  }
  if (!skipBiomes) {
    for (int i = 0; i < 50; i += 1) {
      for (Biome b : biomes) {
        b.update();
      }
    }


    for (Biome b : biomes) {
      b.swapLists();
      b.checkAlive();
    }

    for (int i = biomes.size()-1; i >= 0; i -= 1) {
      if (!biomes.get(i).alive) {
        biomes.remove(i);
      }
    }
  }
  //addBiomes();
  mapGraphics.updatePixels();
  mapGraphics.stroke(255, 64);
  for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {
    mapGraphics.line(x, 0, x, MAP_HEIGHT);
  }

  for (int y = 0; y < MAP_HEIGHT; y += BLOCK_WIDTH) {
    mapGraphics.line(0, y, MAP_WIDTH, y);
  }


  if (!biomesChecked && biomes.size() == 0) {

    SetBiomeCheck(1, 4, false);
    //checkBiomes(2, 3, false);
    //checkBiomes(3, 2, false);
    //checkBiomes(4, 1, false);
    //checkBiomes(4, 8, true);
    //setMissedBiomes();
    biomesChecked = true;
  }

  checkBiomes();




  mapGraphics.endDraw();
  image(mapGraphics, 0, 0, width, height);
  text("(" + mouseX + "," + mouseY + ")"+
    "\n(" + (mouseX / RES) + "," + (mouseY/ RES) + ")"+
    "\n(" + (cbx) + "," + (cby) + ")"
    , 10, 10);
}

void setMissedBiomes() {
  for (int x = 0; x < MAP_WIDTH; x += 1) {
    for (int y = 0; y < MAP_HEIGHT; y += 1) {
      if (typeMap[x][y] != null && typeMap[x][y] == TYPES.INTERIOR) continue;
      if (biomeMap[x][y] == -1) continue;
      if (biomeMap[x][y] != 0) continue;

      biomeMap[x][y] = base.id;
    }
  }
}

boolean cbActive = false;
int cbx = -1;
int cby = -1;
int cbiterations = -1;
int cbThreshhold = -1;
boolean cbChangeSet = false;


void SetBiomeCheck(int iterations, int threshhold, boolean changeSet) {
  cbx = 0;
  cby = 0;
  cbiterations = iterations;
  cbThreshhold = threshhold;
  cbChangeSet = changeSet;
  cbActive = true;
}

void checkBiomes() {
  if (!cbActive) return;

  for (int s = 0; s < MAP_WIDTH; s += 1) {
    int x = cbx;
    int y = cby;
    cbx += 1;
    if (cbx > MAP_WIDTH-1) {
      cbx = 0;
      cby += 1;
      if (cby > MAP_HEIGHT-1) {
        cby = 0;
        cbiterations -= 1;
        if (cbiterations < 0) {
          cbActive = false;
        }
      }
    }
    //for (int i = 0; i < iterations; i += 1) {
    //  for (int x = 0; x < MAP_WIDTH; x += 1) {
    //    for (int y = 0; y < MAP_HEIGHT; y += 1) {

    if (typeMap[x][y] != null && typeMap[x][y] == TYPES.INTERIOR) continue;
    if (biomeMap[x][y] == -1) continue;
    if (!cbChangeSet && biomeMap[x][y] != 0) continue;

    HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
    for (int xx = -1; xx <= 1; xx += 1) {
      int xp = x + xx;
      for (int yy = -1; yy <= 1; yy += 1) {
        int yp = y + yy;
        if (xp == x && yp == y) continue;
        if (!OOB(xp, yp)) {
          int v = biomeMap[xp][yp];

          if (v > 0) {
            if (map.containsKey(v)) {
              map.put(v, map.get(v)+1);
            } else {
              map.put(v, 1);
            }
          }
        }
      }
    }

    int largest = -1;
    int idOfLargest = -1;

    for (int id : map.keySet()) {
      int v = map.get(id);
      if (v > largest) {
        largest = v;
        idOfLargest = id;
      }
    }

    if (idOfLargest > 0 && largest > cbThreshhold) {

      biomeMap[x][y] = idOfLargest;
    }
  }
  //    }
  //  }
  //}
}

void keyReleased() {
  println(key);
  if (key == 'S' || key == 's') {
    saveFrame("data/output/####.png");
  }
}

void mouseClicked() {
  reset();
}
