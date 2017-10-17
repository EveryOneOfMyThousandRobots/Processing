class Slider {
  PVector pos, dims;
  PVector valuePos;
  float value = 0;
  float min, max;
  String name;
  Slider(String name, float ypos, float min, float max) {
    pos = new PVector(0, ypos);
    dims = new PVector(width , 20);
    this.min = min;
    this.max = max;
    value = 0.5;
    valuePos = new PVector();
    calc();
    this.name = name;
  }
  
  void calc() {
    valuePos.x = map(value, 0, 1, 0, width - 20);
    valuePos.y = pos.y;
  }
  
  boolean clicked() {
    float mx = mouseX;
    float my = mouseY;
    if (mx >= 0 && mx <= width - 20 && my >= pos.y && my <= pos.y + dims.y) {
      value = map(mx, 0, width - 20, 0, 1);
      calc();
      return true;
    }
    return false;
  }
  
  void draw() {
    fill(128,100);
    noStroke();
    rect(pos.x, pos.y, dims.x, dims.y);
    fill(128,200);
    rect(valuePos.x, valuePos.y, dims.y, dims.y);
    
    fill(255,100);
    text(name + ": " + nf(getValue(), 3, 3), pos.x + 5, pos.y + dims.y - 3);
  }
  
  float getValue() {
    return map(value, 0, 1, min, max);
  }
  
  
 
}