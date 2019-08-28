class Eye {
  float angle, viewDistance;
  PVector pos = new PVector();
  Mob parent;
  Eye(Mob parent, float angle, float viewDistance) {
    this.angle = angle;
    this.viewDistance = viewDistance;
    this.parent = parent;
  }
  
  
  void draw() {
    pos.x = parent.pos.x + parent.radius * cos(parent.facing + angle);
    pos.y = parent.pos.y + parent.radius * sin(parent.facing + angle);
    stroke(255);
    fill(0,255,0);
    ellipse(pos.x, pos.y, 3, 3);
    
  }
  
  
}
