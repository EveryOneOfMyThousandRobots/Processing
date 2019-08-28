class BlackHole {
  PVector pos;
  float rs,mass;
  BlackHole(float x, float y, float m) {
    mass = m;
    pos = new PVector (x,y);
    rs = (2 * G * mass) / pow(C,2);
    
  }
  String toString() {
    return "mass(" + nfc(mass,4) + "), pos(" + floor(pos.x) + "," + floor(pos.y) + "), rs(" + nfc(rs,12) + ")";
  }
  
  
  void attract(Photon p) {
    PVector force = PVector.sub(this.pos, p.pos);
    float r = force.mag();
    float fg = (G * this.mass) / (r*r);
    force.setMag(fg*delta);
    p.vel.add(force);
    p.vel.setMag(C);
  }
  
  void draw() {
    noStroke();
    fill(0);
    ellipse(pos.x, pos.y, rs, rs);
    
    noFill();
    stroke(100,64);
    strokeWeight(3);
    ellipse(pos.x, pos.y, rs*3, rs*3);
    
    ellipse(pos.x, pos.y, rs*1.5, rs*1.5);
    strokeWeight(1);
  }
}
