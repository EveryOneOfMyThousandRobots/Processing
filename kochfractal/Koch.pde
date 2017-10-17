class Koch {
  PVector start, end;
  Koch (PVector start, PVector end) {
    this.start = start.copy();
    this.end = end.copy();
  }
  
  void draw() {
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }
  
  PVector kochA() {
    return start.copy();
  }
  
  String toString() {
    return "(" + start.x + "," + start.y + ")->(" + end.x + "," + end.y + ")";
  }
  
  
  PVector kochB() {
    PVector v = PVector.sub(end, start);
    v.div(3);
    v.add(start);
    return v;
  }
  
  PVector kochC() {
    PVector a = start.copy();
    
    PVector v = PVector.sub(end, start);
    v.div(3);
    a.add(v);
    rotate(v, -radians(60));
    a.add(v);
    return a;
  }
  
  PVector kochD() {
    PVector v = PVector.sub(end, start);
    v.mult(2/3.0);
    v.add(start);
    return v;
  }
  
  PVector kochE() {
    return end.copy();
  }
}

public void rotate(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x * cos(theta) - v.y * sin(theta);
  v.y = xTemp * sin(theta) + v.y * cos(theta);
  
  
}