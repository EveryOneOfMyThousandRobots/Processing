
class FloorType {
  final color col;
  final String name;

  FloorType (color c, String name) {
    this.col = c;
    this.name = name;
  }


  void draw(float x, float y, float w, float h) {
    if (debug) {
    stroke(0);
    } else {
      noStroke();
    }
      
    fill(col);
    rect(x, y, w, h);
  }
}




class Tile {
  PVector pos;
  PVector dims;
  int[][] floorTypes;  
  float tw;

  Tile(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    tw = 5;
    floorTypes = new int[floor(dims.x * (1/tw))][floor(dims.y * (1/tw))];



    for (int xi = 0; xi < floorTypes.length; xi += 1) {
      for (int yi = 0; yi < floorTypes[xi].length; yi += 1) {
        float xx = (pos.x + xi * tw) * NOISE_FACTOR;
        float yy = (pos.y + yi * tw) * NOISE_FACTOR;
        float fr = noise(xx, yy);
        int f = -1;
        if (fr >= WATER_LOW && fr < WATER_HIGH) {
          f = FLOOR_TYPE_WATER;
        } else if (fr >= GRASS_LOW && fr < GRASS_HIGH) {
          f = FLOOR_TYPE_GRASS;
        } else if (fr >= ROCK_LOW && fr < ROCK_HIGH) {
          f = FLOOR_TYPE_ROCK;
        } else if (fr >= MOUNTAIN_LOW && fr < MOUNTAIN_HIGH) {
          f = FLOOR_TYPE_MOUNTAIN;
        }

        //int f = floor(fr * float(FLOOR_TYPE_HIGHEST+1));

        //int f = floor(random(FLOOR_TYPE_HIGHEST+1));

        floorTypes[xi][yi] = f;
      }
    }
  }



  void draw() {
    for (int xi = 0; xi < floorTypes.length; xi += 1) {
      for (int yi = 0; yi < floorTypes[xi].length; yi += 1) {
        FloorType ft = getFloor(floorTypes[xi][yi]);
        float x = pos.x + float(xi) * tw;
        float y = pos.y + float(yi) * tw;
        ft.draw(x, y, tw, tw);
      }
    }
    if (debug) {
      stroke(255);
      noFill();
      rect(pos.x, pos.y, dims.x, dims.y);
    }
  }
}
