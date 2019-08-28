class Tile {
  int hashCode() {
    return (x + "_" + y).hashCode();
  }
  
  boolean equals(Tile o) {
    return (hashCode() == o.hashCode());
      
    
  }
  ArrayList<Tile> neighbours; 
  final float world_x, world_y;
  final int x, y;
  PImage sprite;
  Tile(int x, int y) {
    this.x = x;
    this.y = y;
    world_x = x * TILE_SIZE;
    world_y = y * TILE_SIZE;
  }

  void draw() {
    stroke(255);
    fill(0);
    rect(world_x, world_y, TILE_SIZE, TILE_SIZE);
  }
}
