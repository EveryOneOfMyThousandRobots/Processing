enum FloorType {
  LAND, SEA;
}

class Map {
  PGraphics map;
  PGraphics food;
  final float width;
  final float height;
  float zoffset = 0;
  color sea = color(32, 32, 32);
  color land = color(200, 200, 200);


  Map(int w, int h) {
    map = createGraphics(w, h);
    food = createGraphics(w, h);
    this.width = map.width;
    this.height = map.height;
  }

  int[] getLand() {
    int[] coords = null;

    while (coords == null) {
      int xx = floor(random(this.width));
      int yy = floor(random(this.height));

      FloorType f = get(xx, yy);

      if (f == FloorType.LAND && !occupied(xx, yy)) {

        coords = new int[2];
        coords[0] = xx;
        coords[1] = yy;
      }
    }


    return coords;
  }


  float getFood(int x, int y) {
    if (x < 0 || x > this.width -1 || y < 0 || y > this.height - 1) {
      return 0;
    }
    color c = food.get(x, y);
    return map(alpha(c), 0, 255, 0.001,1);
  }

  FloorType get(int x, int y) {
    if (x < 0 || x > this.width -1 || y < 0 || y > this.height - 1) {
      return FloorType.SEA;
    }
    color c = map.get(x, y);
    if (c == land) {
      return FloorType.LAND;
    } else {
      return FloorType.SEA;
    }
  }


  boolean occupied(int x, int y) {
    if (x < 0 || x > this.width -1 || y < 0 || y > this.height - 1) {
      return true;
    } 

    Cell c = cells[x][y];
    return c != null;
  }
  
  float foodXOffset = 0;
  float foodYOffset = 0;
  float foodZOffset = 500;

  void generate() {
    zoffset += 0.01;
    map.beginDraw();
    food.beginDraw();
    map.loadPixels();
    food.loadPixels();
    int xi = 0;
    int yi = 0;
    for (float x = 0; x < this.width; x += 1) {
      xi = floor(x);
      for (float y = 0; y < this.height; y += 1) {
        yi = floor(y);
        float v = noise(x / 100.0, y / 100.0, zoffset);
        float fv = noise((x + foodXOffset) / 100, (y + foodYOffset) / 100.0, zoffset + foodZOffset);

        if (v > 0.45) {
          map.pixels[xi + yi * floor(this.width)] = land;
          food.pixels[xi + yi * floor(this.width)] = color(255, map(fv, 0, 1, 0, 255));
        } else {
          map.pixels[xi + yi * floor(this.width)] = sea;
          food.pixels[xi + yi * floor(this.width)] = color(255, 0);
        }
      }
    }
    food.updatePixels();
    map.updatePixels();
    map.endDraw();
    food.endDraw();
  }
}
