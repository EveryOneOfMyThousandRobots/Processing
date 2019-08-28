class Particle {
  float viewAngle = radians(45);
  float angleInc = radians(.5);
  PVector pos = new PVector(AREA_WIDTH / 2, AREA_HEIGHT / 2);
  PVector vel, acc;
  float angle = 0;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  ArrayList<Wall> walls = new ArrayList<Wall>();
  Particle() {
    
    vel = new PVector();
    acc = new PVector();
    int index = 0;
    for (float a = -(viewAngle/2); a < (viewAngle/2); a += (viewAngle / float(AREA_WIDTH))) {
      rays.add(new Ray(pos, a, index));
      index += 1;
    }
    
    //rays.add(new Ray(pos, 0));
    
    
  }
  
  void lookAt(PVector p) {
    angle = PVector.sub(p,pos).heading();
  }
  
  void applyForce(PVector pForce) {
    acc.add(pForce);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(3);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.9);
    
    
    
    walls.clear();
    for (Polygon p : polys) {
      for (Wall w : p.walls) {
        walls.add(w);
      }
    }
  }

  void draw() {
    for (Ray r : rays) {
      r.draw();
    }
  }
  void cast() {
    //angle = (angle + angleInc) % TWO_PI;
    for (Ray r : rays) {
      r.updateAngle(angle);
      //r.update();
      
      r.cast(walls);
    }
  }
}
