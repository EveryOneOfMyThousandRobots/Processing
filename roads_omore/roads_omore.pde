enum TYPE {
  GROUND, 
    ROAD, 
    BUILDING
}

TYPE[][] map;

final int BLOCK_SIZE = 16;


final int MA = 16 * 20;
final int MD = 16 * 20;

PGraphics mapG;
void setup() {
  size(800, 800);
  map = new TYPE[MA][MD];
  for (int x = 0; x < MA; x += 1) {
    for (int y = 0; y < MD; y += 1) {
      map[x][y]= TYPE.GROUND;
    }
  }
  noSmooth();
  
  verticalRoads();
  horizRoads();
  
  mapG = createGraphics(MA, MD);
  mapG.beginDraw();
  mapG.loadPixels();
  //vertical roads




  for (int x = 0; x < MA; x += 1) {
    for (int y = 0; y < MD; y += 1) {
      TYPE t = map[x][y];

      switch (t) {
      case GROUND:
        mapG.pixels[y * mapG.width + x] = color(0, 100, 0);

        break;
      case ROAD:
        mapG.pixels[y * mapG.width + x] = color(0);
        break;
      case BUILDING:
        mapG.pixels[y * mapG.width + x] = color(200);
        break;
      }
      //print(" (" + x + "," + y + ")");
      //point(x, y);
    }
  }
  mapG.updatePixels();
  mapG.endDraw();
}


void draw() {
  background(0);
  image(mapG, 0, 0, width, height);
}
