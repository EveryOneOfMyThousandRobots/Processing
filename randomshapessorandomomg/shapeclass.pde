class CS {
  PVector[] points = new PVector[6];
  boolean[] used  = new boolean[6];

  PVector centre;
  color c;


  CS() {
    c = color(random(255), random(255), random(255));
  }



  void draw() {
    noStroke();
    fill(c);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    vertex(points[0].x, points[0].y);
    endShape();
  }
}