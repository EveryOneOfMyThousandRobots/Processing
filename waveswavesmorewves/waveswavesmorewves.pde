float res = 255;
class Wave {
  PVector pos;
  PVector dims;
  float freq;
  float duration;
  float secondWidth;
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  
  Wave(float x, float y, float w,float h, float freq, float duration) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    this.freq = freq;
    this.duration = duration;
        
    secondWidth = dims.x / duration;
    println(secondWidth);
    float angle = 0;
    float ai;
    float rs = secondWidth / res;
    ai = (secondWidth * rs);
    float dyo2 = dims.y / 2;
    for (float xx = pos.x; xx < pos.x + dims.x; xx += rs) {
      angle += ai;
      points.add(new PVector(xx, (dyo2 + (sin(angle) * dyo2));
    }
    
  }
  
  void draw() {
    stroke(255);
    fill(0);
    rect(pos.x, pos.y, dims.x, dims.y);
    line(pos.x, pos.y + (dims.y / 2), pos.x + dims.x, pos.y + (dims.y / 2));
    
    for (float xx = pos.x; xx < pos.x + dims.x; xx += secondWidth) {
      line(xx, pos.y, xx, pos.y + dims.y);
    }
    
    for (PVector p : points) {
      point(p.x, p.y);
    }
    
  }
}
ArrayList<Wave> waves = new ArrayList<Wave>();
void setup() {
  size(800,600);
  waves.add(new Wave(0,0,width,height/2,2,1));
  
}

void draw() {
  background(0);
  for (Wave w : waves) {
    w.draw();
  }
}
