enum FACING {
  NORTH,SOUTH,EAST,WEST;
}
ArrayList<Building> buildings = new ArrayList<Building>();
class Building {
  int x, y,w,h;
  FACING facing;
  
  
  Building(int x, int y, int w, int h, FACING facing) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.facing = facing;
  }
  
  
}
