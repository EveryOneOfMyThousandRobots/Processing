class Tile {
  PVector pos;
  int row, col;
  float size;

  int value;

  Tile(int row, int col, float size) {
    this.row = row;
    this.col = col;
    this.size = size;

    pos = new PVector(col * size, row * size);
    value = 0;
  }

  void draw() {
    stroke(0);
    fill(200);
    rect(pos.x, pos.y, size, size);
    if (value > 0) {

      fill(0);
      text(value, pos.x + 10, pos.y + size - 10);
    }
  }
}