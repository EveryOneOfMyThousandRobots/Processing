class Tail {
  PVector pos;
  float a, ta, t;
  float min_a, max_a;
  Tail parent;
  Tail child;
  
  Tail(Tail parent) {
    this.parent = parent;
    
    pos = getPos();
    a = parent.a;
    min_a = parent.min_a;
    max_a = parent.max_a -20;
    
  }
  
  PVector getPos() {
    
    float x = parent.pos.x + 16 * cos(radians(a));
    float y = parent.pos.y + 16 * sin(radians(a));
    PVector  p = new PVector(x,y);
    
    
    
    
    
    return p;
  }
  
  
  void addChild() {
    if (child == null) {
      child = new Tail(this);
    } else {
      child.addChild();
    }
  }
  
  Tail(float x, float y, float min_a, float max_a) {
    pos = new PVector(x,y);
    this.parent = null;
    this.min_a = min_a;
    this.max_a = max_a;
  }
  
  
  void update() {
    ta += radians(1);
    t = map(sin(ta),-1,1,0,1);
    a = lerp(min_a, max_a,t);
    if (parent == null) {
      
    } else {
      pos.set(getPos());
    }
    
    if (child != null) {
      child.update();
    }
  }
  
  void draw() {
    if (parent != null) {
      stroke(255);
      line(parent.pos.x, parent.pos.y, pos.x, pos.y);
      
    }
    
    if (child != null) {
      child.draw();
    }
  }
  
  
  
  
  
  
}
Tail tail;
void setup() {
  size(400,400);
  tail = new Tail(width / 2, height / 2, 190, 100);
  for (int i = 0; i < 8; i += 1) {
    tail.addChild();
  }
  
  
}


void draw() {
  background(0);
  tail.update();
  tail.draw();
}
