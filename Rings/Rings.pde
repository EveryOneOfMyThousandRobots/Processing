ArrayList<Ring> rings = new ArrayList<Ring>();
void setup() {
  size(400,400);
  int num = 10;
  float r = 20;
  float ri = 5;
  float ao = 0.01;
  float ai = 0.0001;
  for (int i = 0; (r + (ri * i)) < width; i++) {
    Ring ring = new Ring(width / 2, height / 2, r + (ri * i), num, (ao * i), ai + (ai * i));
    rings.add(ring);
  }
  background(0);
  
}

void draw() {
  
  fill(0, 10);
  rect(0,0,width,height);
  for (Ring r : rings) {
    r.update();
    r.draw();
  }
}

class Ring {
  float x,  y;
  float r;
  float d;
  int num;
  float ao,ai;
  
  Ring(float x, float y, float r, int num, float ao, float ai) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.d = r * 2;
    this.num = num;
    this.ao = ao;
    this.ai = ai;
  }
  
  void update() {
    ao += ai;
  }
  
  void draw() {
    stroke(255);
    noFill();
    float ai = TWO_PI / num;
    for (int i = 0; i < num; i++) {
      float xx = x + r * cos(ao + (i * ai));
      float yy = y + r * sin(ao + (i * ai));
      
      point(xx,yy);
    }
  }
  
}