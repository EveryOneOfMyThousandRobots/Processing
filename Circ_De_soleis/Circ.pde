class Circ {
  Circ parent = null;
  Circ child;
  
  PVector pos;
  float angle = 0;
  float angleInc = 0;
  float freq = 0;
  
  Circ(Circ parent, float freq) {
    this.parent = parent;
    this.freq = freq;
  }
  
  Circ(float freq) {
    this.freq = freq;
    
  }
  
  void addChild(float freq) {
    if (child == null){
      child = new Circ(this,freq);
    } else {
      child.addChild(freq);
    }
  }
  
  
  void update(float deltaTime) {
    
    angle += angleInc;
    if (angle > TWO_PI) {
      angle -= TWO_PI;
    }
    
    
    
    
    if (child != null) {
      child.update(deltaTime);
    }
    
    
    
  }
  
  
}
