class Line {
  PVector from, to; 

  Line(PVector from, PVector to) {
    this.from = from.copy();
    this.to = to.copy();
  }

  void draw() {
    line(from.x, from.y, to.x, to.y);
  }
}