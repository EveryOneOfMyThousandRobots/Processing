class Circ {
  PVector c;
  float angle;
  PVector v;
  float ai;
  float r = R_2 * 0.8;
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  Circ xParent, yParent;
  final boolean hasParents; 
  
  Circ (Circ xParent, Circ yParent) {
    
    this.xParent = xParent;
    this.yParent = yParent;
    c = new PVector(xParent.c.x, yParent.c.y);
    v = new PVector(0,0);
    hasParents = true;
    update();
  }
  
  Circ(float x, float y, float ai) {
    c = new PVector(x,y);
    v = new PVector(0,0);
    this.ai = ai;
    hasParents = false;
    update();
    
  }
  
  
  void update() {
    if (hasParents) {
      v.x = xParent.v.x;
      v.y = yParent.v.y;
      points.add(v.copy());
    } else {
      angle = (angle+ ai) % TWO_PI;
      v.x = r * cos(angle);
      v.y = r * sin(angle);
      points.add(v.copy());
    }
    
    if (points.size() > MAX_POINTS) {
      points.remove(0);
    }
    
    
  }
  
  void draw() {
    stroke(255);
    //noFill();
    //ellipse(c.x, c.y, r*2, r*2);
    fill(255);
    ellipse(c.x + v.x, c.y + v.y, 5,5);
    noFill();
    beginShape();
    for (PVector p : points) {
      vertex(c.x + p.x, c.y + p.y);
    }
    endShape();
  }
}
