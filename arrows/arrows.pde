class Arrow {
  PVector pos;
  
  Arrow sub = null;
  Arrow parent = null;
  
  void addSubArrow() {
    if (sub != null) {
      sub = new Arrow(this);
    } else {
      sub.addSubArrow();
    }
  }
  
  Arrow(int num) {
    for (int608'[
  }
  
  Arrow(Arrow parent) {
    this.parent = parent;
     this.pos = parent.pos; 
  }
  
  
}

Arrow arrow;
void setup() {
  size(400,400);
}
