int DRAW_ME_ID = 0;

class DrawMe {
  boolean highlighted = false;
  final int id;
  {
    DRAW_ME_ID += 1;
    id = DRAW_ME_ID;
  }
  color c;
  PVector pos;
  float s;

  DrawMe(float x, float y, float s, color c) {
    pos = new PVector(x, y);
    this.c = c;
    this.s = s;
  }
  void draw() {

    GAME_WINDOW.fill(c,255);
    if (highlighted) {
      GAME_WINDOW.stroke(255);
    }else {
      GAME_WINDOW.stroke(0);
    }
    GAME_WINDOW.rect(pos.x, pos.y, s, s);
  }

  int hashCode() {
    return id * 11;
  }

  boolean equals(DrawMe o) {
    return o.id == id;
  }
}
