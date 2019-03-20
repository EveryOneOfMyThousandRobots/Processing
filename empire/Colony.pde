int COLONY_ID = 0;
class Colony {
  PGraphics image;
  int x, y;
  int startingNum;
  color col;
  ArrayList<Cell> cells = new ArrayList<Cell>();
  final int id;
  {
    COLONY_ID += 1;
    id = COLONY_ID;
  }
  
  int hashCode() {
    return id * 17;
  }
  
  boolean equals(Colony o) {
    return this.id == o.id;
  }
  
  float avgStrength = 0;
  
  

  Colony (int x, int y, int startingNum, color c) {
    //image = createGraphics(map.width, map.height);
    this.col = c;
    for (int i = 0; i < startingNum; i += 1) {
      int xx = x + floor(random(-10,10));
      int yy = y + floor(random(-10,10));
      
      if (!map.occupied(xx,yy) && map.get(xx,yy) == FloorType.LAND) {
        cells.add(new Cell(xx,yy,c, this));
      }
    }
    
  }
  
  void update() {
    avgStrength = 0;
    int count = 0;
    for (int i = cells.size() -1; i >= 0; i -=1 ) {
      Cell c = cells.get(i);
      if (!c.alive) {
        cells.remove(i);
      } else {
        avgStrength += c.strength;
        count += 1;
        c.update();
      }
    }
    avgStrength /= float(count);
  }
  
  void draw() {
    loadPixels();
    
    for (Cell c : cells) {
      //int x = floor(map(c.x, 0, map.width, 0, width));
      //int y = floor(map(c.y, 0, map.height, 0, height));
      for (int xx = c.x * 2; xx < (c.x * 2) + 2; xx += 1) {
        for(int yy = c.y * 2; yy < (c.y * 2) + 2; yy += 1) {
          //pixels[(c.x*2) + (c.y *2) * floor(width)] = col;
          pixels[xx + yy * floor(width)] = col;
        }
      }
      
    }
    updatePixels();
  }
}
