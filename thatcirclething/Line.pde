class Line {
  PVector from, to, cntr;
  
  
  Line (float x1, float y1, float x2, float y2) {
    from = new PVector(x1,y1);
    to = new PVector(x2, y2);
    cntr = PVector.sub(to, from).div(2);
    cntr.add(from);
  }
  
  void draw() {
    stroke(255);
    noFill();
    line(from.x, from.y, to.x, to.y);
    ellipse(cntr.x, cntr.y, 5, 5);
  }
}
