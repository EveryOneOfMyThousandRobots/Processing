class P {
  PVector pos;
  color c;
  float dim;
  float zs, zd;
  
  P(float x, float y, float z, color c, float dim) {
    zd = 1;
    zs = random(0.01, 0.05);
    this.c = c;
    this.pos = new PVector(x,y,z);
    this.dim = dim;
  }
  void draw() {
    fill(c);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(dim);
    
    popMatrix();
    
  }
  
  void update() {
    
  }
}

class Field {
  ArrayList<P> points = new ArrayList<P>();
  
  Field(float w, float h, float th, float tw) {
    for (float yy = 0; yy < h; yy += th) {
      for (float xx = 0; xx < w; xx += tw) {
        P p = new P(xx, yy, 0, color(random(255), random(255), random(255)), th);
        points.add(p);
      }
    }
  }
  
  void draw() {
    for (P p : points) {
      p.draw();
    }
  }
}