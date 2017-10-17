String alpha = "ABCDEFGHJKMPQRSTWXYZ";

class Aisle {


  DIR direction;
  Grid grid;
  int index;
  String settings;
  int sx, sy;
  Aisle(Grid grid, int index, DIR direction, String settings) {
    sx = 1 + (index * 3);
    sy = 0;
    this.direction = direction;
    this.index = index;
    this.settings = settings;
    this.grid = grid;
  }

  void init() {
    int i = -1;
    for (int ci = 0; ci < settings.length(); ci += 2) {
      String c = settings.substring(ci, ci+2);
      println(c);
      if (direction == DIR.NORTH) {
        if (i == -1) {
          //grid.cells[sx][sy + grid.rows] = new Cell(
        }
      }
    }
  }
}