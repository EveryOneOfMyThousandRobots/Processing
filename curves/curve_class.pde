class Curve {
  PGraphics image;
  float freqA, freqB;
  PVector pos;
  PVector dims;
  PVector centre;
  
  float valA, valB;
  float x,y;
  float prevX = -1, prevY =-1;
  float r;
  
  Curve(float x, float y, float w, float h, float fA, float fB) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    r = dims.x / 4;
    image = createGraphics(floor(w),floor(h));
    valA = 0;
    valB = 0;
    freqA = fA;
    freqB = fB;
    centre = new PVector(w/2, h/2);
    
  }
  
  void update() {
    valA += radians(freqA);
    if (valA > TWO_PI) valA -= TWO_PI;
    valB += radians(freqB);
    if (valB > TWO_PI) valB -= TWO_PI;
    
    
    
    x = centre.x  + r * cos(valA + valB);
    y = centre.y + r * sin(valA + valB);
    
    
    
    
    
  }
  
  void clear() {
    image.beginDraw();
    image.background(0);
    image.endDraw();
  }
  
  
  void draw() {
    image.beginDraw();
    image.stroke(255);
    if (prevX == -1 && prevY == -1) {
      image.point(x,y);
    } else {
      image.line(prevX, prevY, x,y);
    }
    //image.point(x,y);
    image.endDraw();
    
    prevX = x;
    prevY = y;
  }
}
