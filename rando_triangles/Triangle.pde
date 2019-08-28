class Triangle {
  final Polygon p;
  color c;


  Triangle(Polygon p) {
    this.p = p;
    c = color(random(255), 100, random(64, 255));
  }

  void draw() {
    noStroke();
    fill(c);
    beginShape();
    for (int i = 0; i < p.npoints; i += 1) {
      vertex(p.xpoints[i], p.ypoints[i]);
    }
    endShape(CLOSE);
  }
}
