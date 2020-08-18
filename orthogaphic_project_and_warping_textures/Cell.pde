int ID = 0;

class Cell {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  boolean wall = false;
  int[] faces = new int[6];
  boolean[] visible = new boolean[6];
  final int x,y;
  final World world;
  Cell(World world,int x, int y) {
    this.world = world;
    this.x = x;
    this.y = y;
    visible[FACE_FLOOR] = true;
  }
  
  @Override
  boolean equals(Object o) {
    if (o instanceof Cell) {
      Cell co = (Cell) o;
      if (co.id == id) {
        return true;
      }
    }
    return false;
  }
  
  int hashCode() {
    return Integer.hashCode(id);
  }
}
