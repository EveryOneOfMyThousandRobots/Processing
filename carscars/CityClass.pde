class City {
  ArrayList<Building> buildings = new ArrayList<Building>();
  ArrayList<Road> roads = new ArrayList<Road>();
  ArrayList<Junction> junctions = new ArrayList<Junction>();

  City () {
    float w = width;
    float h = height;
    int tileWidth = width / 9;
    int tileHeight = height / 9;
    int tileRight = (int)w / tileWidth;
    int tileDown = (int)w / tileHeight;

    int ta = 0;
    int td = 0;
    for (int y = 0; y < height; y += tileHeight) {
      td = 0;   
      for (int x = 0; x < width; x += tileWidth) {
        Building b = null;
        Road r = null;
        Junction j = null;
        if ((td == 0 && ta == 0) || (td == 0 && ta == tileRight - 1) || (td == tileDown - 1 && ta == 0) || (td == tileDown - 1 && ta == tileRight -1)) {
          b = new Building(x,y, tileWidth, tileHeight);
        } else if (td % 2 == 0) {
          if (ta % 2 == 0) {
          } else {
            b = new Building(x,y, tileWidth, tileHeight);  
          }
          
        } else {
          if (ta % 2 == 0) {
            r = new Road(x,y, tileWidth, tileHeight);  
          }
        }


        td += 1;
      }
      ta += 1;
    }
  }
}

class Building {
  PVector pos, dim;
  Building(float x, float y, float w, float h) {
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
  }

  void draw() {
    stroke(0);
    fill(128);
    rect(pos.x, pos.y, dim.x, dim.y);
  }
}

static final int NORTHSOUTH = 0;
static final int EASTWEST = 1;
class Road {
  PVector pos, dim;
  int direction;

  Road(float x, float y, float w, float h, int direction) {
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);

    if (direction != 0) {
      this.direction = EASTWEST;
    } else {
      this.direction  = NORTHSOUTH;
    }
  }

  void draw() {
    noStroke();
    fill(200);
    rect(pos.x, pos.y, dim.x, dim.y);
    if (direction == EASTWEST) {
      stroke(0);
      line(pos.x, pos.y + (dim.y / 2), pos.x + dim.x, pos.y + (dim.y / 2));
    } else {
      line(pos.x + (dim.x / 2), pos.y + dim.y, pos.x + (dim.x / 2), pos.y);
    }
  }
}

class Junction {
  PVector pos, dim;
  boolean hasNorth, hasSouth, hasEast, hasWest;
  Junction(float x, float y, float w, float h, int directions) {
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
    hasNorth = (directions & 1) != 0;
    hasSouth = (directions & 2) != 0;
    hasEast = (directions & 4) != 0;
    hasWest = (directions & 8) != 0;
  }
}