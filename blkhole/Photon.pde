class Photon {
  
  PVector pos;
  PVector prev;
  PVector vel;
  boolean dead = false;
  float dist = 0;
  color col;
  Photon(float x, float y, float xv) {
    prev = new PVector(x,y);
    pos = new PVector(x,y);
    vel = new PVector(xv,0);
    float from = PI - (PI / 60.0);
    float to = PI + (PI / 60.0);
    float angle = random(from,to);
    
    vel.add(PVector.fromAngle(angle));
    
    vel.setMag(C);
    
    col =  color(map(y, 0, height, 0, 255), 255, 255, 128);
  }
  
  
  
  
  void update() {
    prev.set(pos);
    pos.x += vel.x * dt;
    pos.y += vel.y * dt;
    dist = PVector.dist(pos, m87.pos);
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height || dist < m87.rs) {
      dead = true;
    }
  }
  
  void draw() {
    particleGraphics.stroke(col);
    //particleGraphics.strokeWeight(3);
    particleGraphics.line(prev.x, prev.y, pos.x, pos.y);
    //particleGraphics.strokeWeight(1);
  }
  
}
