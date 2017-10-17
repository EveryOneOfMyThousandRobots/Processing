float M = random(-1,1);
float B = random(-1,1);

float f(float x) {
  //y = mx + b
  return (M * x) + B;
}

class Point {
  float x, y;
  int label;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Point() {
    x = random(-1,1);
    y = random(-1,1);
    
    float lineY = f(x);
    if (y > lineY) {
      label = 1;
    } else {
      label = -1;
    }
  }
  
  float getX() {
    return map(x, -1,1,0, width);
  }
  
  float getY() {
    return map(y, -1,1,height,0);
  }
  
  void show() {
    stroke(0);
    if (label == 1) {
      fill(0);
    
    } else {
      fill(255);
    }
    float px = getX();
    float py = getY();
    ellipse(px,py,8,8);
  }
}