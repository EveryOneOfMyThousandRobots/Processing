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

final int MAP_WIDTH = 200;
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
  cbReset();
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

    if (biomes.size() == 0) {
      if (!cbActive) {
        switch(cbStep) {
        case 0:
          SetBiomeCheck(1, 4, false);
          break;
        case 1:
          SetBiomeCheck(2, 3, false);
          break;
        case 2:
          SetBiomeCheck(1, 8, false);
          break;
        case 3:
          setMissedBiomes();
        }

        //
        //
        //
        //checkBiomes(4, 8, true);
        //
      }
    }

    checkBiomes();
  }
  //addBiomes();
  mapGraphics.updatePixels();
  mapGraphics.stroke(255, 64);
  for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {
    mapGraphics.line(x, 0, x, MAP_HEIGHT);
  }
  
  //mapGraphics.stroke(255,64);
  //mapGraphics.fill(51,128);
  //for (Building b : buildings) {
  //  mapGraphics.rect(b.x, b.y, b.w, b.h);
  //}

  for (int y = 0; y < MAP_HEIGHT; y += BLOCK_WIDTH) {
    mapGraphics.line(0, y, MAP_WIDTH, y);
  }







  mapGraphics.endDraw();
  image(mapGraphics, 0, 0, width, height);
  text("(" + mouseX + "," + mouseY + ")"+
    "\n(" + (mouseX / RES) + "," + (mouseY/ RES) + ")"+
    "\n(" + (cbx) + "," + (cby) + ")"
    , 10, 10);

  if (cbActive) {
    stroke(255);
    line(0, cby * RES, width, cby *RES);
  }
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
